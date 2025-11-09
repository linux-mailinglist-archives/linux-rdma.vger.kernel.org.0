Return-Path: <linux-rdma+bounces-14328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F52C436CB
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 01:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 470954E392D
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 00:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E014F9FB;
	Sun,  9 Nov 2025 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NVr2gHCV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE991BC3F
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762647734; cv=none; b=Mj9Yv6weSfEnKS4lqlRkS4Wc+CqqNxg8IG8O6ARjcvtFaCDIbWVOOXCp/IgJV7MJRROt2oA2c2yWNwHNAFxWOtymHBN+5bjcSGM7/ZCyyeYyKnFdIMdJwqL3KkmOAkz9g2hmWZ74/7rVE9kqk34xxDZaQGVZ+T49FGiobEly4rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762647734; c=relaxed/simple;
	bh=JipylUYry9nfJlUtJl1DFsVjiN6FzH66JEInJNLszL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOFMK0x94bGisKVI58h93xwIqYrBN0VSmMyQJAyF8uu1k2eKd6eTdJ1NbMjk6ELdVk0A3QCWGQpFij9eUf89sA4AcY/s8mH7ojKcVrboGgBgjr9SHF6Zl8fd4D7DuQ7/4rGKerd8KpaSpX5JScSLB6uxcll7gT0FCLAxK/9nENM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NVr2gHCV; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b22a30986fso182054885a.2
        for <linux-rdma@vger.kernel.org>; Sat, 08 Nov 2025 16:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762647730; x=1763252530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K31hFtxJgbyCyrj7RV7S1El/yp7JxQIwL9GxNfnQUBI=;
        b=NVr2gHCVJoWRmPERPwOAvzGH/VPqGhvgTOcjnF1Uvi8Fw6clKyve2bphL9uZ68IKt/
         sNdYROmrhnDPLfuuj0JA3+ng1ah+JLByLYV+kWsgoC6QmxlaEvWe5F+WTBqUtnRTEBmu
         rpYjI3CMWV39JijQGNSzJDYLi3XB1MUUY5WLNHOMvptETEKfpC/DeIres224TfbNtbJx
         U0EXDrn04MdmB2NO6JiysyAx1GTLanLk2OH1tfaDQ1ISpgJmk4o4ontmkx8uMD/+9b+H
         JCnIVecHxoUaldvzjEPv5JGLNt8ecdS85mwnmpTapKrg2lxCFtioQoY9VEfA/4buRcxI
         y0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762647730; x=1763252530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K31hFtxJgbyCyrj7RV7S1El/yp7JxQIwL9GxNfnQUBI=;
        b=kI7rPzrXVottajeG54Ke5RaTxQxlTKawLG3Eucf0EtMTY/nzWjZUXuyqYYZlR3Lk8n
         OvV4Z0C5x3KjYTIayzHH2k87HaHFychMZ8Av+BW6dvTRSYigeHu36XzfL+T0DPCy9ZFc
         e2rb4ipy2TF5czpzXpyy3SCEbtrlQVNLhZNnvlPkOYZRmd1+4oMu4BEe/+DgAqPazu5G
         SdWAWrN1KudgEhj/PBBIMHGdEd4ysLGKh7iIop685E3HovuP+7J7FgKpjkvtTEUdxm03
         ociVrkHlTuJ9Amd6OTwYd/5uhpAAL6f/c5W6d7AZOhiC+osGOcnrLGTnIRSwkHxaBQL7
         LHfg==
X-Forwarded-Encrypted: i=1; AJvYcCV7pcpylKHGcmkmQ8NXwIc9UnkSAiW+LHmFButoHCDvUj2lVNBOtqc1HJUbefFMEqMLc0Cq1tNUqDt2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1RAi9P9r8EalR2q+ImOMdRFUIhsIf3pszTs5nK52PZ58I4MLH
	Ui+dx881vBqfo+uYkHheQ3Nhm5U601QpwRPOCYUhNRKcvEGP2dvJxv1Pm6uA180II1c=
X-Gm-Gg: ASbGncvYRqIxu4vYgrYha6QlMy/N58NocxnH4V7ajq6HJ70loG2DxYM09MAaHQlzik3
	uHyt6k11VJXMJwS3SZ6s4f1Yjl7PmuLzUgz4MozpF+fqDstdc8dh1q7kZmgZVjHpBG7BACWy0BO
	UcaZPb7ZszoACbrMkabNphivJm8BkV3r8qWC1IJ3PbVxeAyFPoA9bC5qVfPOd9+2TCJjCTa+g5m
	/PmCH03ZsE0RAZfRaj4CSkZM9PJZIuk9zEtDvBmWksJbb2xenTHn9ycRBg+3sLV0bcb8hguoMAX
	aRj1/4/+95b8W0OS/76tawA/e+6DMAsERXZKrUeQLe+1mFymMwkpbXZvXYir2kZf+3iI6kjafAC
	eE8MgI6TK7Oe4Rleg/pf/Wa3kyMYvTcrZTfS8izIvs58k52ZFaQ9Z83edTpJdmkoJpG2PVOKAOr
	PrM3Ig3/TL5/iYzgY5lonfSU2TyZdOnFEJZ2yacytSx/Y85ork69jXTFOg6enQ0dXu9UQ=
X-Google-Smtp-Source: AGHT+IFZHIFepY0nuzFaRsmlYMI9En4ELLmVws54SavMv3OOIXlsN3wbgqr5IW0SGVME/mJbgD6RNw==
X-Received: by 2002:a05:620a:2914:b0:8b1:59d9:f1e5 with SMTP id af79cd13be357-8b257eee7b0mr523033085a.30.1762647729631;
        Sat, 08 Nov 2025 16:22:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b26b597c63sm54782485a.58.2025.11.08.16.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 16:22:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vHtC3-00000008XBA-3FNb;
	Sat, 08 Nov 2025 20:22:07 -0400
Date: Sat, 8 Nov 2025 20:22:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] RDMA/core: Check for missing DGID attribute in
 ib_nl_is_good_ip_resp()
Message-ID: <20251109002207.GF1859178@ziepe.ca>
References: <20251108034336.2100529-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108034336.2100529-1-kriish.sharma2006@gmail.com>

On Sat, Nov 08, 2025 at 03:43:36AM +0000, Kriish Sharma wrote:
> KMSAN reported a use of uninitialized memory in hex_byte_pack()
> via ip6_string() when printing %pI6 from ib_nl_handle_ip_res_resp().
> Previously, ib_nl_process_good_ip_rsep() used the 'gid' without
> verifying that the LS_NLA_TYPE_DGID attribute was present.
> 
> This patch adds a check for the DGID attribute in ib_nl_is_good_ip_resp(),
> returning false if it is missing. This prevents uninitialized memory
> usage downstream in ib_nl_process_good_ip_rsep().
> 
> Suggested-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
> Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
> v2:
>  - Added check for LS_NLA_TYPE_DGID in ib_nl_is_good_ip_resp() to
>    avoid uninitialized 'gid' usage, as suggested by Vlad Dumitrescu.
> 
> v1: https://lore.kernel.org/all/20251107041002.2091584-1-kriish.sharma2006@gmail.com
> 
>  drivers/infiniband/core/addr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index 61596cda2b65..dde9114fe6a1 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -93,13 +93,16 @@ static inline bool ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
>  	if (ret)
>  		return false;
>  
> +	if (!tb[LS_NLA_TYPE_DGID])
> +		return false;
> +
>  	return true;
>  }
>  
>  static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
>  {
>  	const struct nlattr *head, *curr;
> -	union ib_gid gid;
> +	union ib_gid gid = {};

Let's drop this.

Looking at the whole flow, it looks like it is not using
nla_parse_deprecated properly.. I think it should look like this which
will fix the issue and make it run faster:

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 61596cda2b65f3..35ba852a172aad 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -80,37 +80,25 @@ static const struct nla_policy ib_nl_addr_policy[LS_NLA_TYPE_MAX] = {
 		.min = sizeof(struct rdma_nla_ls_gid)},
 };
 
-static inline bool ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
+static void ib_nl_process_ip_rsep(const struct nlmsghdr *nlh)
 {
 	struct nlattr *tb[LS_NLA_TYPE_MAX] = {};
+	union ib_gid gid;
+	struct addr_req *req;
+	int found = 0;
 	int ret;
 
 	if (nlh->nlmsg_flags & RDMA_NL_LS_F_ERR)
-		return false;
+		return;
 
 	ret = nla_parse_deprecated(tb, LS_NLA_TYPE_MAX - 1, nlmsg_data(nlh),
 				   nlmsg_len(nlh), ib_nl_addr_policy, NULL);
 	if (ret)
-		return false;
+		return;
 
-	return true;
-}
-
-static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
-{
-	const struct nlattr *head, *curr;
-	union ib_gid gid;
-	struct addr_req *req;
-	int len, rem;
-	int found = 0;
-
-	head = (const struct nlattr *)nlmsg_data(nlh);
-	len = nlmsg_len(nlh);
-
-	nla_for_each_attr(curr, head, len, rem) {
-		if (curr->nla_type == LS_NLA_TYPE_DGID)
-			memcpy(&gid, nla_data(curr), nla_len(curr));
-	}
+	if (!tb[LS_NLA_TYPE_DGID])
+		return;
+	memcpy(&gid, nla_data(tb[LS_NLA_TYPE_DGID]), sizeof(gid));
 
 	spin_lock_bh(&lock);
 	list_for_each_entry(req, &req_list, list) {
@@ -137,8 +125,7 @@ int ib_nl_handle_ip_res_resp(struct sk_buff *skb,
 	    !(NETLINK_CB(skb).sk))
 		return -EPERM;
 
-	if (ib_nl_is_good_ip_resp(nlh))
-		ib_nl_process_good_ip_rsep(nlh);
+	ib_nl_process_ip_rsep(nlh);
 
 	return 0;
 }



