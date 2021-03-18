Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4258340C9E
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Mar 2021 19:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCRSOG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Mar 2021 14:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhCRSOB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Mar 2021 14:14:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D92C06174A;
        Thu, 18 Mar 2021 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=oNxAZsSCTP12OX72KAVK8m4kV5XdYZWSZ+Au8Sl2D1w=; b=F4rjpjFjZUxrwecsDB15Ke1njU
        59p4J0jkkS7WVsjVEu9rXTCrXiMgd+yga4CxXfiiXdY5xVqV2RAc//3/NoIPNERnsAI1Hymy4WndZ
        3WQIUvICn9SrCKbBfkCf16jxozktGZxaHrMGuFkLW2oDvxlw/XEBhTMLumyWPb/gypp5vVlyQniW6
        A1/s405CBTP0I0LhLdoycWccJ2zKksjGGjN2PYfpYSCi+Qru9uFwcIm0CbxTA/GqwHMDOA3i72zl6
        qBnXQ73WtxeB7fUG+dxUC3HWGMAbIOtfivzQCa/taGUwg553vvAXRv2QkcHe5UKIZ5Si2Qj1Xe1xi
        AmQISXTQ==;
Received: from [2601:1c0:6280:3f0::9757]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMx8t-003Kjs-AM; Thu, 18 Mar 2021 18:13:36 +0000
Subject: Re: [PATCH] RDMA/include: Mundane typo fixes throughout the file
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210318100453.9759-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <29120631-dae4-a262-d22e-31d65b350a63@infradead.org>
Date:   Thu, 18 Mar 2021 11:13:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318100453.9759-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/18/21 3:04 AM, Bhaskar Chowdhury wrote:
> 
> s/proviee/provide/
> s/undelying/underlying/
> s/quesiton/question/
> s/drivr/driver/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  include/rdma/rdma_vt.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
> index 9fd217b24916..0af89cedfbf5 100644
> --- a/include/rdma/rdma_vt.h
> +++ b/include/rdma/rdma_vt.h
> @@ -92,7 +92,7 @@ struct rvt_ibport {
>  	/*
>  	 * The pkey table is allocated and maintained by the driver. Drivers
>  	 * need to have access to this before registering with rdmav. However
> -	 * rdmavt will need access to it so drivers need to proviee this during
> +	 * rdmavt will need access to it so drivers need to provide this during
>  	 * the attach port API call.
>  	 */
>  	u16 *pkey_table;
> @@ -230,7 +230,7 @@ struct rvt_driver_provided {
>  	void (*do_send)(struct rvt_qp *qp);
> 
>  	/*
> -	 * Returns a pointer to the undelying hardware's PCI device. This is
> +	 * Returns a pointer to the underlying hardware's PCI device. This is
>  	 * used to display information as to what hardware is being referenced
>  	 * in an output message
>  	 */
> @@ -257,7 +257,7 @@ struct rvt_driver_provided {
>  	void (*qp_priv_free)(struct rvt_dev_info *rdi, struct rvt_qp *qp);
> 
>  	/*
> -	 * Inform the driver the particular qp in quesiton has been reset so
> +	 * Inform the driver the particular qp in question has been reset so
>  	 * that it can clean up anything it needs to.
>  	 */
>  	void (*notify_qp_reset)(struct rvt_qp *qp);
> @@ -281,7 +281,7 @@ struct rvt_driver_provided {
>  	void (*stop_send_queue)(struct rvt_qp *qp);
> 
>  	/*
> -	 * Have the drivr drain any in progress operations
> +	 * Have the driver drain any in progress operations
>  	 */
>  	void (*quiesce_qp)(struct rvt_qp *qp);
> 
> --


-- 
~Randy

