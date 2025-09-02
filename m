Return-Path: <linux-rdma+bounces-13031-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A643B3F64D
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 09:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153B63ACAFC
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 07:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BD32E6CA5;
	Tue,  2 Sep 2025 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KK8nmWXS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YpCWR0bY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E7A2E54D1;
	Tue,  2 Sep 2025 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797184; cv=none; b=SVbAtPGDvLlSwvts2UsECHePmO4b7B6QqfVLdbJHZMGOYiLxRdL47P9RYz2drczWuldR3Di6Ct+Re1rD5g8gHz+xKay7u5P9dE2dinWeXta09yPKFB4NE7bKU0QKfSNHr8eZLueGjVssHLY0uwXSzF4+ZzR0uRKiYUtg+lx5gi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797184; c=relaxed/simple;
	bh=oGDss44/R+p3Gc+SA7s6Q0fiu6Jp4FtRYb3A6LAVp9Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XJY3Hm6VazjthwEZ1k76s8CoFSUP6VlmXsc6iPsiDcwaksn/Xi7IhwfLZO522imtS+auCegX7VGwt1GJhL0Jmz/nD4WnzgWty37Xytr76gZxd5BeinsEtR+9fO159GAUbcIUKKYwdYCs3ZPKkuVfUkqhymtUoNJ0LuLtlz3eZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KK8nmWXS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YpCWR0bY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D8321400256;
	Tue,  2 Sep 2025 03:13:01 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-06.internal (MEProxy); Tue, 02 Sep 2025 03:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756797181;
	 x=1756883581; bh=toLDHdQc9Oyqd27CNLCz1AEnk/JhIml68A5kSp/J1Zg=; b=
	KK8nmWXSOG9eC9vm3zqHImXC3Vd9TFcsAgdrRcN65bfkzWBqxJdOEbpZqxFjJLFO
	bxAsZzlsicmJ/Cwb4FRQU4OIjvTJMW5VEBMawaQavkFNInl2eMSaA93E3a3sudu7
	4g/fHQouWTjBvJhB+hgUOub0LWAVrhnYnRkoFvCdm/VFoRWOgoTTiAcpiiL1gbi+
	xQ6v9HWhrnolGXJdCd4e2evm1gxiOpVr+vevQkz9Ti7T3e/GHD56cxCiZAL2uLKT
	TD38scTPaFsoYFbBZQra9218+mOvPsuf7qgHI99Mgvp7GyjXdAPLmfcZgBRH5AQt
	NpoLOkma7nQYd7ovt8bTCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756797181; x=
	1756883581; bh=toLDHdQc9Oyqd27CNLCz1AEnk/JhIml68A5kSp/J1Zg=; b=Y
	pCWR0bYSjqAa3379JZWa5VPBaaZCz/CEiS40YM+SpHxXbEc1qZyCDwG1yy2tY88r
	E8vp5t2+2/ggdwQw1qxjWoBSta0fROKt/kYV1wRvtAhSgLjSs9ys6u4QgyuXpjj4
	tTnq5XudJAlpGhqVaxgJji56FS2GiIe2OpxQGUkpuqVJ/ecmNZgQiy1tmG8T+H1N
	jWk3Y5ex9SvLdrSbgpD1XrLil4qe7y87wwrQA9ma3zWchVUvNI+RlfEHRurNM09e
	4+Bf63BFamWhkoq7oWctiBfBEzkSaFGIs11L+ML6jatDYuqId/dZwIloNX/Ri0pn
	3S5oU/pTvQ0lQWqsrrRzg==
X-ME-Sender: <xms:_Ji2aPLnlh-WUgwhMOI2Zg7Mdy4FYXqxIxIczT8bOzH6p2kkAuJflQ>
    <xme:_Ji2aDJKsv47xLFxUaz8AE-jPCXRWW3QSjsb6PDpgr7XR9hd72ylLk77W9LTz3FPw
    40jre6gW0DnumR3igA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegfeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:_Ji2aLoTvCpUu1JQ-VNzygKegdd3NWLEUNTPHaAN_6muHs0p2V6wrA>
    <xmx:_Ji2aG8zF0WHaRHEHckXZMp1eTEo3LqTzgC7TY9GWMtiPgqtt3xSmw>
    <xmx:_Ji2aM2kmYrNinIuYis4tYswnSOc60WLMQdoDYYAGUbnw5rJfsGFSg>
    <xmx:_Ji2aBkBM2toMFghTbYgHBM1LtOipJDbWkg8nbLomGULkqGzgXkG9w>
    <xmx:_Zi2aKkeDCsn6nW1Om00piS6NXNJNdF-aJagw9JQbvmzL4_w2iEXDKvb>
Feedback-ID: ibd7e4881:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 85B99780070; Tue,  2 Sep 2025 03:13:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYqA-NWBhw8c
Date: Tue, 02 Sep 2025 00:12:22 -0700
From: James <bold.zone2373@fastmail.com>
To: "Mahanta Jambigi" <mjambigi@linux.ibm.com>, alibuda@linux.alibaba.com,
 "Dust Li" <dust.li@linux.alibaba.com>, sidraya@linux.ibm.com,
 wenjia@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 "Simon Horman" <horms@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Message-Id: <27d1804c-27c4-488f-9f35-1913a7f7015f@app.fastmail.com>
In-Reply-To: <7bd60e6d-4b33-4a04-998b-0be163a6fdb0@linux.ibm.com>
References: <20250901030512.80099-1-bold.zone2373@fastmail.com>
 <7bd60e6d-4b33-4a04-998b-0be163a6fdb0@linux.ibm.com>
Subject: Re: [PATCH v2] net/smc: Replace use of strncpy on NUL-terminated string with
 strscpy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Sep 1, 2025, at 11:40 PM, Mahanta Jambigi wrote:
> On 01/09/25 8:34 am, James Flowers wrote:
>> strncpy is deprecated for use on NUL-terminated strings, as indicated in
>> Documentation/process/deprecated.rst. strncpy NUL-pads the destination
>> buffer and doesn't guarantee the destination buffer will be NUL
>> terminated.
>> 
>> Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
>> ---
>> V1 -> V2: Replaced with two argument version of strscpy
>> Note: this has only been compile tested.
>> 
>>  net/smc/smc_pnet.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
>> index 76ad29e31d60..b90337f86e83 100644
>> --- a/net/smc/smc_pnet.c
>> +++ b/net/smc/smc_pnet.c
>> @@ -450,7 +450,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
>>  		return -ENOMEM;
>>  	new_pe->type = SMC_PNET_IB;
>>  	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
>> -	strncpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
>> +	strscpy(new_pe->ib_name, ib_name);
>
> I tested your changes by creating a Software PNET ID using *smc_pnet*
> tool & it works fine. Your changes are similar to ae2402b(net/smc:
> replace strncpy with strscpy) commit.
>
> Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>
>>  	new_pe->ib_port = ib_port;
>>  
>>  	new_ibdev = true;

Thank you for doing that test, Mahanta. Thanks to all who have reviewed so far.

Best regards,
James Flowers

