Return-Path: <linux-rdma+bounces-13012-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF00B3D20F
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Aug 2025 12:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB44189EA2B
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Aug 2025 10:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B3253932;
	Sun, 31 Aug 2025 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EB9G+bU0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XogKtSbF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3BC1DDC2B;
	Sun, 31 Aug 2025 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756635485; cv=none; b=D8VxA8h92xhXaUaeDxf8mnzJKYBAAZvW0VRL/qXfTCOEJKeP5BnFXa4KYC8fhCo7F/th01iMvVsI1bhbIK9P6X9ArtrcwZ2lrH0antYFiBtYsc8cWJUNb86OvL8E34xvj69x1mW/oMhLqxQQgir+PmiLT37L+j341hgbn3NfNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756635485; c=relaxed/simple;
	bh=IjTYrbBQSPkwxsasV3ZlplpdpKXrOFp0IayCgXtPes0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ehit2rwNuRMCi56l6ifmfQZUIsg0TyJe98MsNw8U2r3wtNtB3TAxY1IO2jwL1oxbTlhPBIrjXQq1Xh6JmVuFA6yiOIGcqSJWIHc8ETcIpInG5lemVVMt6cloIvf6fSg+enVgOnQtOL2HjOtUyhUUVfUOq0OlJV3sH1Ir8Kb3MR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EB9G+bU0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XogKtSbF; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 549CB7A006D;
	Sun, 31 Aug 2025 06:18:02 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-06.internal (MEProxy); Sun, 31 Aug 2025 06:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756635482;
	 x=1756721882; bh=cBqMVR6uqZHT5hLteGW5CLt4CXa6io3Ge5VLQmeY+u8=; b=
	EB9G+bU0aZue6wB8MyHS9YXRsGUbpXMTlon/5WAEFj0g5Wrt/WhOx3xohoT6jPo8
	KT6fC1xsOhLddjjs5Ag2BMPLLHAI8VNwlMGIhhg05LRtyruFeDq098VMgWagGkj5
	THrtJL4KLpizjYmBujoFqqnNv+MH80rIoEwdBqRgZKwA2YQUmY1SrPh36Vfm4tiE
	Euvm+6mllOSRF0u6myIkqj4mogYhA6IZGXp6sWmsqi/92UYIGHiLREbR5VNSXseE
	JDks9PCyrS72VpCRVnhfCXaDn781KrXWV2UVXr+YVLnORL1LZ9bnpSvfpPLvGbK0
	mCaYOKn7aZO36zfk8rPyXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756635482; x=
	1756721882; bh=cBqMVR6uqZHT5hLteGW5CLt4CXa6io3Ge5VLQmeY+u8=; b=X
	ogKtSbFudSgjAPdHjAn2kLy5FMwAk7AzNzZvVnm07lZvRWQqFfFV5JDxVm+Bznpg
	tdKk+sZ1Yzj2mxrW6H8M5gdyxM6vsTnQYh+5ETddmU5xqynQOa2baNkm1B+LbNeG
	Bf2poVDlNiCLxVqZ7DcR59CRttBUOanhZRHSfX51aPChrp9JCrPOCL3mX1VEKO/r
	KRSALavb4zPs0ulqOT13fzVBOIonfhkkAX/qZV16/HvTCXjswa/4Nxae3Lbfh5kV
	rxE1FO10KbkWxVnPDA+XP8RnX0ApGWxgZAE4uXmLuPHwHKEMzsVL45CfZvqKZsOt
	0hFxzpDRdRu72EPO1HOsw==
X-ME-Sender: <xms:WCG0aGN_fcKVIQyvjYDeeFl1yGAUG6V99bblBc93iuCTvcLzLCY0dA>
    <xme:WCG0aE9LHCHNPVN1LuZIU_5eCQSYIyecm66Pjwq67b4uS7WBmZ1Owjrg7_4WqYQsS
    bO6RlPmM-n3NwpphOI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpeflrghmvghs
    uceosgholhgurdiiohhnvgdvfeejfeesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeffleeuffekgfefhfejudetheevgfduudefffeifeetveekteefhefffffg
    heejhfenucffohhmrghinhepthgvshhtvggurdhnvghtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsgholhgurdiiohhnvgdvfeejfeesfhgr
    shhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthho
    pegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrlhhisghuuggrsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpth
    htohepughushhtrdhliheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthho
    pehguhifvghnsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepthhonh
    ihlhhusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepmhhjrghmsghi
    ghhisehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:WCG0aOLkjOXqN6rJoVKA1UQ0LIwRZDTHjPwShOCxSeA9E7iwqUaNPw>
    <xmx:WCG0aO-Nss1w1J_AnXJrQk6RCw1sUI85vFgf0Zb6j2wX-GDsxzsgxw>
    <xmx:WCG0aADasLgMO_F620l24tlGg7ikE1K8906AILzr9hWBoWsyfqeAXg>
    <xmx:WCG0aIrWVxpToHIWq8VYCSqG1GC5zn8FTP5-QR-6Moff--9cSXntkg>
    <xmx:WiG0aIp52qlhtzLh-iwA4EcGo62o8__piBmuviB6sp2AE6X5t_SiEgE_>
Feedback-ID: ibd7e4881:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C1F277840CC; Sun, 31 Aug 2025 06:18:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJv3-LmMGI5N
Date: Sun, 31 Aug 2025 03:17:40 -0700
From: James <bold.zone2373@fastmail.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 "Shuah Khan" <skhan@linuxfoundation.org>
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Message-Id: <4919e89e-cf4c-4ef1-af9a-0a94e92614ac@app.fastmail.com>
In-Reply-To: <20250831095535.176554-1-bold.zone2373@fastmail.com>
References: <20250831095535.176554-1-bold.zone2373@fastmail.com>
Subject: Re: [PATCH] net/smc: Replace use of strncpy on NUL-terminated string with
 strscpy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, Aug 31, 2025, at 2:49 AM, James Flowers wrote:
> strncpy is deprecated for use on NUL-terminated strings, as indicated in
> Documentation/process/deprecated.rst. strncpy NUL-pads the destination
> buffer and doesn't guarantee the destination buffer will be NUL
> terminated.
>
> Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
> ---
> Note: this has only been compile tested.
>
>  net/smc/smc_pnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 76ad29e31d60..5cfde2b9cad8 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -450,7 +450,7 @@ static int smc_pnet_add_ib(struct smc_pnettable 
> *pnettable, char *ib_name,
>  		return -ENOMEM;
>  	new_pe->type = SMC_PNET_IB;
>  	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
> -	strncpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
> +	strscpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
>  	new_pe->ib_port = ib_port;
> 
>  	new_ibdev = true;
> -- 
> 2.50.1

Please disregard. Sorry, just noticed I should have used the two argument version of strscpy. I will send a V2. 

