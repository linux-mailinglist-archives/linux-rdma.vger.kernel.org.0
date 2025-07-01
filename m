Return-Path: <linux-rdma+bounces-11789-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A15AEEFBF
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 09:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D241BC55D3
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C7D25BF00;
	Tue,  1 Jul 2025 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="GfhxbFUk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C772627;
	Tue,  1 Jul 2025 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751354892; cv=none; b=NO7CBtgCQqj9PjnTDT7GLIYv4N11pnRiGV21ge4gC56UNbdGevtFB0fjbL0QjvOewiJZ8mnhhy/eTt/g3iRIVPaTH9upS1c9PCPCx4vC85FJtBt1DsrIDgtsPB/l3xgoyXvR0STC59BMDxblI65JL7sPqMZ1ul96+C0LqHPfLQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751354892; c=relaxed/simple;
	bh=YDEbnGhuOWLsVA+sCNJxV/TpybCXlMAB4+pgRB4AFgQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VoLulGQ7m6deCn8WSj1nKxct2k+BnPCjJWmcwivO8C+54LHZwLpX5d8MygqIyKl7aaSCv0wQ/wdr+XzFTRDkhuwkJ+1JXdWja5QA58K3FLMjJpMdKQg7hq4OkRqKJtRA8BJJm76xoYFPMlEYazk55C7mkVCTqDA1hEEGr3G8o5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=GfhxbFUk; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWVOt-00DBu9-Kt; Tue, 01 Jul 2025 09:27:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=Rkdk2rPksLpTTEM7JfKIBHo3x2rKNHPrlN3G2XHmJyE=; b=GfhxbFUkoy8GS/INc8QHy3peIx
	zAk3bRrn5f22LX1XhffCbRVtSG+IYOYUXmC1eqG8GcYmhckSwbJ6DPzJVW2/NkXn6DVcg571sDI8W
	SBaiZX9KdVOX2NxHUQvl+wMDViHZz+OPBtof82UPBLiSEM906u4K3k6c1hYe96ZxN3+JUQszHcP30
	j7791qWTu0J4Msgw5d5I38wcYToDoRC4UNlZx+N+vEju0IE6ooDRvIDj1jqHLXZ0yOUpE4D9BC9kb
	7m3+oUF+k2A1/XqBip9cjSX6OsFA5oEZIEudkXa+7eB/myI6rAi/i8cQTYcTNp3/as9IzM1JwI7rp
	7p/Am+Xw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWVOs-0000QG-4G; Tue, 01 Jul 2025 09:27:30 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWVOZ-001vyL-CH; Tue, 01 Jul 2025 09:27:11 +0200
Message-ID: <beea4b9f-657f-4f98-a853-e40a503e2274@rbox.co>
Date: Tue, 1 Jul 2025 09:27:09 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next v2 0/9] net: Remove unused function parameters in
 skbuff.c
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Ayush Sawal <ayush.sawal@chelsio.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
 <20250630181847.525a0ad6@kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250630181847.525a0ad6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 03:18, Jakub Kicinski wrote:
> On Thu, 26 Jun 2025 10:33:33 +0200 Michal Luczaj wrote:
>> Couple of cleanup patches to get rid of unused function parameters around
>> skbuff.c, plus little things spotted along the way.
>>
>> Offshoot of my question in [1], but way more contained. Found by adding
>> "-Wunused-parameter -Wno-error" to KBUILD_CFLAGS and grepping for specific
>> skbuff.c warnings.
> 
> I feel a little ambivalent about the removal of the flags arguments.
> I understand that they are unused now, but theoretically the operation
> as a whole has flags so it's not crazy to pass them along.. Dunno.

I suspect you can say the same about @gfp. Even though they've both became
irrelevant for the functions that define them. But I understand your
hesitation. Should I post v3 without this/these changes?

What's netdev's stance on using __always_unused in such cases?

Thanks,
Michal


