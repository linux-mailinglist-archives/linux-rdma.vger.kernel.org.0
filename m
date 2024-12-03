Return-Path: <linux-rdma+bounces-6191-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA4E9E18C2
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 11:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A016F166A58
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942681E0B78;
	Tue,  3 Dec 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uflgpnjr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E11E0B7A
	for <linux-rdma@vger.kernel.org>; Tue,  3 Dec 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220265; cv=none; b=sPuT5pPHcMdollkzO6X/3Qs2BDfpR1J74SfQQrbHzl9GI9hOoJoVkWX85aV2KYngqdNtR7MnNNB5t+TvO7bPCl6RhBaE2TfJZH7Pb9M7ZEJwKowT6GzFIwtYd/fRTGfmNFhW+En2agwMo+fe10pvwmgOug39+bCkSuicokgjbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220265; c=relaxed/simple;
	bh=HQ44SPqVqENJTbQrYY2kZjK603Ln//DhUNKAfXJorFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1MyP/6cFSkLPlq7R2RfeNlojVR1YJZodt+3LMbKMnZjvAHKtA6lIMaxzcgKglRv4coKcL9n9+QvqkbmuY/kKxdW1kSX4WHq/adJLn0fkNU1S4AJVFnVoj8HhvmLw01Kx03C0jILywLPG1A+wcJoxepP9F5h5fIQ3SrjncZbujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uflgpnjr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733220262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6Yz/wh2DDx3kpOempfoxxI4Bvmg2kZ7VVay1dulTJk=;
	b=Uflgpnjr2EI17bH3TFgQx3OaKrSpMfeVr+1GQp2onAL3Z2LM7xGPyyrClUrMRJ5+bjtI+M
	rE5qQym3FsHVTJrwT4o9QDau03G8jVSEJld03G5qQAx52hZVkxVrxJBJz6pwtDE1ToKork
	6+fB9HvyrZFknmHGlTnfuHdcaA4pGI8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-LkSJd8njNTGlS4UIcGl2ow-1; Tue, 03 Dec 2024 05:04:20 -0500
X-MC-Unique: LkSJd8njNTGlS4UIcGl2ow-1
X-Mimecast-MFC-AGG-ID: LkSJd8njNTGlS4UIcGl2ow
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d87f4c26a7so66206626d6.2
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2024 02:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220259; x=1733825059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6Yz/wh2DDx3kpOempfoxxI4Bvmg2kZ7VVay1dulTJk=;
        b=nMZ3U+I1dcjVMhwId1V3uF/IU63jvRRJtvWqd7S03aMjqHzBfKyA8nUrmNL/Tojp0E
         r9yuuIPK9vehZDY7r3aZoobHnIsr62L5eJcBbZCYfJ1eAWOrk8TiH7AIzFFyHpNowM7J
         i0C5IvU8LGC659UyYzX2+4a8KXDLTWEylA52QJLyconJlB9/NdmJdEynfEzFpXCtp/9Q
         LqqkfSLNGgGJFD1166NRtK35gSfGXVwpj49HDzI/Xqbnim/jj9yUe3nh5JNo2/kmVPmi
         DIL2o2/7R4vegAMeeMDBwe0jiDQJ4asCVMw0IWThfFKI1OF2FlkFcih23MN6sfIxbZPN
         kgXQ==
X-Gm-Message-State: AOJu0YxaK6u+lBqrJ5FlL9IBB37iH9mZ1fnnO6zy+u6T0nL4J+bPp90u
	dTCmJ9kmRu2/JxhoIObiHwOC3DJVncNeBqdKjkLhkz81ZZ895ljHhQBuzh9GnfJ2rAvsTvaxB80
	85u0ZXe12PrHXrRNbzHKXMDIDwJxhd2i+47MpY11X34+sFC2gMaWomMdxX6s=
X-Gm-Gg: ASbGncuiINeexrHdezd60LI4T82MVtgEyfXIDgN0l1RRm/x7g6d0QFyAt8Noo/788NG
	9dy7hfyZ4DGHUq1su9vqwtikEM3d67ZmGROQ7wKLLILVaJz2whpua0KRbe+T+yBjNrHXpy3hJoS
	xMey8XmcKedW+GUQB52HfH2d8PvsNQGXNO4JvnsNYdB3qi6Y8Ld8XpRxahWS75KZQrtzrAMpI+B
	FdIf/gDgpIU7XMoTHOFWGbG/uIKSi9cXzGVKBPNJTV+K53ppxOKkUlvJcoF/P1kmDbyAVyyB4Zm
X-Received: by 2002:ad4:5dc2:0:b0:6d8:a39e:32a4 with SMTP id 6a1803df08f44-6d8b7389459mr32032306d6.25.1733220259675;
        Tue, 03 Dec 2024 02:04:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1K5nqkk2YWvJZ36M/30xTQ0u4uphAR9Xza3eEbd6ZgDvKckxS8QXJ6vo2298noBcWsm6LJA==
X-Received: by 2002:ad4:5dc2:0:b0:6d8:a39e:32a4 with SMTP id 6a1803df08f44-6d8b7389459mr32032066d6.25.1733220259408;
        Tue, 03 Dec 2024 02:04:19 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849c35efsm496606685a.118.2024.12.03.02.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 02:04:19 -0800 (PST)
Message-ID: <62cd6d62-b233-4906-af4a-72127fc4c0f4@redhat.com>
Date: Tue, 3 Dec 2024 11:04:15 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/6] net/smc: set SOCK_NOSPACE when send_remaining but
 no sndbuf_space left
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
 <20241128121435.73071-3-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241128121435.73071-3-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/28/24 13:14, Guangguan Wang wrote:
> When application sending data more than sndbuf_space, there have chances
> application will sleep in epoll_wait, and will never be wakeup again. This
> is caused by a race between smc_poll and smc_cdc_tx_handler.
> 
> application                                      tasklet
> smc_tx_sendmsg(len > sndbuf_space)   |
> epoll_wait for EPOLL_OUT,timeout=0   |
>   smc_poll                           |
>     if (!smc->conn.sndbuf_space)     |
>                                      |  smc_cdc_tx_handler
>                                      |    atomic_add sndbuf_space
>                                      |    smc_tx_sndbuf_nonfull
>                                      |      if (!test_bit SOCK_NOSPACE)
>                                      |        do not sk_write_space;
>       set_bit SOCK_NOSPACE;          |
>     return mask=0;                   |
> 
> Application will sleep in epoll_wait as smc_poll returns 0. And
> smc_cdc_tx_handler will not call sk_write_space because the SOCK_NOSPACE
> has not be set. If there is no inflight cdc msg, sk_write_space will not be
> called any more, and application will sleep in epoll_wait forever.
> So set SOCK_NOSPACE when send_remaining but no sndbuf_space left in
> smc_tx_sendmsg, to ensure call sk_write_space in smc_cdc_tx_handler
> even when the above race happens.

I think it should be preferable to address the mentioned race the same
way as tcp_poll(). i.e. checking again smc->conn.sndbuf_space after
setting the NOSPACE bit with appropriate barrier, see:

https://elixir.bootlin.com/linux/v6.12.1/source/net/ipv4/tcp.c#L590

that will avoid additional, possibly unneeded atomic operation in the tx
path (the application could do the next sendmsg()/poll() call after that
the send buf has been freed) and will avoid some code duplication.

Cheers,

Paolo


