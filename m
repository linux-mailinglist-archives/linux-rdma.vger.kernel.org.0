Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C71977AC8E
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 17:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfG3PmD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 11:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfG3PmD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 11:42:03 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DFFA218D8;
        Tue, 30 Jul 2019 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564501322;
        bh=lDrFBHFeoN04QRjUGenI0+tLI+Mz5oNRcwhty/PjIMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fd3hJmgeMylCPykYK8OESJf5uUGsjqXGiPD0lqbSsNCajIxi61EMlp/l++3d5j06K
         ZPBz/z+CbT6IQrkWu7mTdaSoL5PQPm0p7ShyyzGZiHfwpWg2UgFQ6xbLTRz14phSKZ
         GL/PC7C77sqIxvgIQZ7dc+H+PwfoeldM7UcOD5sg=
Date:   Tue, 30 Jul 2019 18:41:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 1/2] RDMA/core: Introduce ratelimited ibdev
 printk functions
Message-ID: <20190730154148.GG4878@mtr-leonro.mtl.com>
References: <20190730151834.70993-1-galpress@amazon.com>
 <20190730151834.70993-2-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730151834.70993-2-galpress@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 30, 2019 at 06:18:33PM +0300, Gal Pressman wrote:
> Add ratelimited helpers to the ibdev_* printk functions.
> Implementation inspired by counterpart dev_*_ratelimited functions.
>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  include/rdma/ib_verbs.h | 51 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index c5f8a9f17063..356e6a105366 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -107,6 +107,57 @@ static inline
>  void ibdev_dbg(const struct ib_device *ibdev, const char *format, ...) {}
>  #endif
>
> +#define ibdev_level_ratelimited(ibdev_level, ibdev, fmt, ...)           \
> +do {                                                                    \
> +	static DEFINE_RATELIMIT_STATE(_rs,                              \
> +				      DEFAULT_RATELIMIT_INTERVAL,       \
> +				      DEFAULT_RATELIMIT_BURST);         \
> +	if (__ratelimit(&_rs))                                          \
> +		ibdev_level(ibdev, fmt, ##__VA_ARGS__);                 \
> +} while (0)
> +
> +#define ibdev_emerg_ratelimited(ibdev, fmt, ...) \
> +	ibdev_level_ratelimited(ibdev_emerg, ibdev, fmt, ##__VA_ARGS__)
> +#define ibdev_alert_ratelimited(ibdev, fmt, ...) \
> +	ibdev_level_ratelimited(ibdev_alert, ibdev, fmt, ##__VA_ARGS__)
> +#define ibdev_crit_ratelimited(ibdev, fmt, ...) \
> +	ibdev_level_ratelimited(ibdev_crit, ibdev, fmt, ##__VA_ARGS__)
> +#define ibdev_err_ratelimited(ibdev, fmt, ...) \
> +	ibdev_level_ratelimited(ibdev_err, ibdev, fmt, ##__VA_ARGS__)
> +#define ibdev_warn_ratelimited(ibdev, fmt, ...) \
> +	ibdev_level_ratelimited(ibdev_warn, ibdev, fmt, ##__VA_ARGS__)
> +#define ibdev_notice_ratelimited(ibdev, fmt, ...) \
> +	ibdev_level_ratelimited(ibdev_notice, ibdev, fmt, ##__VA_ARGS__)
> +#define ibdev_info_ratelimited(ibdev, fmt, ...) \
> +	ibdev_level_ratelimited(ibdev_info, ibdev, fmt, ##__VA_ARGS__)
> +
> +#if defined(CONFIG_DYNAMIC_DEBUG)
> +/* descriptor check is first to prevent flooding with "callbacks suppressed" */
> +#define ibdev_dbg_ratelimited(ibdev, fmt, ...)                          \
> +do {                                                                    \
> +	static DEFINE_RATELIMIT_STATE(_rs,                              \
> +				      DEFAULT_RATELIMIT_INTERVAL,       \
> +				      DEFAULT_RATELIMIT_BURST);         \
> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);                 \
> +	if (DYNAMIC_DEBUG_BRANCH(descriptor) && __ratelimit(&_rs))      \
> +		__dynamic_ibdev_dbg(&descriptor, ibdev, fmt,            \
> +				    ##__VA_ARGS__);                     \
> +} while (0)
> +#elif defined(DEBUG)

When will you see this CONFIG_DEBUG set? I suspect only in private
out-of-tree builds which we are not really care. Also I can't imagine
system with this CONFIG_DEBUG and without CONFIG_DYNAMIC_DEBUG.

Thanks


> +#define ibdev_dbg_ratelimited(ibdev, fmt, ...)                          \
> +do {                                                                    \
> +	static DEFINE_RATELIMIT_STATE(_rs,                              \
> +				      DEFAULT_RATELIMIT_INTERVAL,       \
> +				      DEFAULT_RATELIMIT_BURST);         \
> +	if (__ratelimit(&_rs))                                          \
> +		ibdev_printk(KERN_DEBUG, ibdev, fmt, ##__VA_ARGS__);    \
> +} while (0)
> +#else
> +__printf(2, 3) __cold
> +static inline
> +void ibdev_dbg_ratelimited(const struct ib_device *ibdev, const char *format, ...) {}
> +#endif
> +
>  union ib_gid {
>  	u8	raw[16];
>  	struct {
> --
> 2.22.0
>
