Return-Path: <linux-rdma+bounces-7651-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ACCA304D5
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 08:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE547A2058
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8CA1EE019;
	Tue, 11 Feb 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aCHvVt2J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEE51EB9FD;
	Tue, 11 Feb 2025 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260195; cv=none; b=FrmvqaSmjyeAuzEM4tT77v1iKDLok0X1ptZmS6eP5Bq8DqnjhNeAItFgT4V3RTTa5/fEl0s2+sXtZwJvhHt2T2ALAsLeVSta452Jn97lHOMHm8YyxCUl53v0Kr4hlkcy2oQ+di8ZsXGCOqUCofQr3eo1ZPDQLl0ecJ5zikeH1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260195; c=relaxed/simple;
	bh=9ZXuDR56VOj3aRUbJ/oIRUrBTTfenvcfHNCEn/YTP4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJNK0amVzmC8e/t4aNVVLkydey4pFUQGBLxjh/4yF8OpH3KfPNphjtSdjZgK7eRILIQ0FmcAHhTrq6Fzz51TqwWqYgpD9a2kPDaITPGg/1IxUgPr/9Q27KCwzemRaaC+M/6KxAtBJp3BrXwGDPAuRPLQh8dEfzQ5fOjZ7vNMf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aCHvVt2J; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739260181; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=E4fujhKTHDMvm3LvF6P6OUjzbktVGbdSMW9p0iJwGt4=;
	b=aCHvVt2JbhmRjhLif/TESL3yzeIGw+9dAjSI5uJymbhkXUilRi739KtPqd/ThJgk56R0MVL72GfRjdtfs49xtKzvtJQgfaTl3IJj+qpPYIfyv5FEFiPSvLfMuDMjGjayEU2E8J2iUAYwbe3hoab8WpHVlp9iWetkSAQlvnUQweU=
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0WPG-4g2_1739260179 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Feb 2025 15:49:41 +0800
Date: Tue, 11 Feb 2025 15:49:38 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, fengwei_yin@linux.alibaba.com
Subject: Re: [PATCH 1/2] net/mlx4: fix build error from usercopy size check
Message-ID: <Z6sBEoUB02Q8paEu@U-V2QX163P-2032.local>
References: <20230418114730.3674657-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418114730.3674657-1-arnd@kernel.org>

Hi Arnd,

On Tue, Apr 18, 2023 at 01:47:11PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The array_size() helper is used here to prevent accidental overflow in
> mlx4_init_user_cqes(), but as this returns SIZE_MAX in case an overflow
> would happen, the logic in copy_to_user() now detects that as overflowing
> the source:
> 
> In file included from arch/x86/include/asm/preempt.h:9,
>                  from include/linux/preempt.h:78,
>                  from include/linux/percpu.h:6,
>                  from include/linux/context_tracking_state.h:5,
>                  from include/linux/hardirq.h:5,
>                  from drivers/net/ethernet/mellanox/mlx4/cq.c:37:
> In function 'check_copy_size',
>     inlined from 'copy_to_user' at include/linux/uaccess.h:190:6,
>     inlined from 'mlx4_init_user_cqes' at drivers/net/ethernet/mellanox/mlx4/cq.c:317:9,
>     inlined from 'mlx4_cq_alloc' at drivers/net/ethernet/mellanox/mlx4/cq.c:394:10:
> include/linux/thread_info.h:244:4: error: call to '__bad_copy_from' declared with attribute error: copy source size is too small
>   244 |    __bad_copy_from();
>       |    ^~~~~~~~~~~~~~~~~
> 
> Move the size logic out, and instead use the same size value for the
> comparison and the copy.
I could hit this build error with latest upstream kernel tree with
gcc 10.2.1 20200825 for arm64 platform. No such build error for x86
platform.

This patch can fix the build error. I am wondering whether you will
push this fix to upstream kernel. You can add:
  Tested-by: Yin Fengwei <fengwei_fyin@linux.alibaba.com>


Regards
Yin, Fengwei

> 
> Fixes: f69bf5dee7ef ("net/mlx4: Use array_size() helper in copy_to_user()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/mellanox/mlx4/cq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
> index 4d4f9cf9facb..020cb8e2883f 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/cq.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
> @@ -290,6 +290,7 @@ static void mlx4_cq_free_icm(struct mlx4_dev *dev, int cqn)
>  static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
>  {
>  	int entries_per_copy = PAGE_SIZE / cqe_size;
> +	size_t copy_size = array_size(entries, cqe_size);
>  	void *init_ents;
>  	int err = 0;
>  	int i;
> @@ -304,7 +305,7 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
>  	 */
>  	memset(init_ents, 0xcc, PAGE_SIZE);
>  
> -	if (entries_per_copy < entries) {
> +	if (copy_size > PAGE_SIZE) {
>  		for (i = 0; i < entries / entries_per_copy; i++) {
>  			err = copy_to_user((void __user *)buf, init_ents, PAGE_SIZE) ?
>  				-EFAULT : 0;
> @@ -315,7 +316,7 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
>  		}
>  	} else {
>  		err = copy_to_user((void __user *)buf, init_ents,
> -				   array_size(entries, cqe_size)) ?
> +				   copy_size) ?
>  			-EFAULT : 0;
>  	}
>  
> -- 
> 2.39.2
> 

