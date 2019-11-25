Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60401109442
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 20:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfKYTcf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Nov 2019 14:32:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36015 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYTcf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Nov 2019 14:32:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id d7so6937841pls.3
        for <linux-rdma@vger.kernel.org>; Mon, 25 Nov 2019 11:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vhwBJ9ELl2RIBcQ1TRzds+GCWMUfOgnotr8oBea/+IM=;
        b=XMETOhzNZVSw1BL1JlgX/0PCmhxaYkqe95LFnz8BTq9PAIDcf+VsXRXmzp7SxDP0yx
         E31xUv86/906wcvjdhyypiq9WoTzxTd4EuFD5Rwmkchk8E7YGYbLv0SLUUPdF6qZGI60
         wkdI3G/SQO0RH4Xpv8jwGQhy6VZ1/TtejbpBVO9GZBBWxqS/Tv8trxk9/2UGb6ivWx6R
         xAyEkpWXGI9PLqzCoX73VXpNXZ2iYixqzbSHPqkCdj6KLiv7Fpeo1UZGia2CGmrq2fdc
         AxNQkhmq5XvNxPbCtf0GBFsaq4tXkX3j2WoQgjkIczylCTkWpWoH8hJ6xdQRXVA8wfBw
         lpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vhwBJ9ELl2RIBcQ1TRzds+GCWMUfOgnotr8oBea/+IM=;
        b=reDx6yoW3ZCvhFVUZPw+gLPcBrZDiEYcW0SSrki61vakxYTA6Eyv5wx715nzQkXQV1
         aGU8/vb+Ttu+B4LRES/jLF3Ga/clAG2q6xnvAmXjemnPWERg9P+3f5Ck5cNw4LdfnCjT
         m3di+gFyoP/4ZbBAJwCTg2sB273xMGw/v1TE3tS5thrW8urjld1tKOd72ND9/RKnmrfW
         nm0RDxJF4Z2CWc9CcjXZmM4rf02z7i7ZpL0sbDHN/Fg+z3G1Dxv26ZvlZHPc837RLec+
         ztisZCO1G+sldVpzyKSrgc1NCcB0ak+RPoLtUBw7YU87teZwsHfz1Lnc2VW+Y190JQFr
         J3xQ==
X-Gm-Message-State: APjAAAWUUoa8pawJpnPPUdlpnkRhu3Sc4UuLXn1xKGJ+DUrSuGrZs67i
        qOoH+uDPD0kr633u2vAOx0wfFStzkY1A0g==
X-Google-Smtp-Source: APXvYqy/5MA4Q9mj8hItYhfR8H8Apoz9OzyAOhZuxwseo8cQAv1bTC24Vt4Fzhznl7ZQPfIPT2FHng==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr30743243plp.18.1574710354881;
        Mon, 25 Nov 2019 11:32:34 -0800 (PST)
Received: from [192.168.4.10] ([107.13.143.123])
        by smtp.gmail.com with ESMTPSA id m7sm9732021pgh.72.2019.11.25.11.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 11:32:34 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] rdma-core: Recognize IBV_DEVICE_LOCAL_DMA_LKEY in
 ibv_devinfo
From:   Andrew Boyer <aboyer@pensando.io>
In-Reply-To: <20191125175603.GB11270@ziepe.ca>
Date:   Mon, 25 Nov 2019 14:32:31 -0500
Cc:     linux-rdma@vger.kernel.org, allenbh@pensando.io
Content-Transfer-Encoding: quoted-printable
Message-Id: <77FA0F51-7A7D-42E3-AC2A-BF65550A4396@pensando.io>
References: <20191125152237.19084-1-aboyer@pensando.io>
 <20191125175603.GB11270@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Nov 25, 2019, at 12:56 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Mon, Nov 25, 2019 at 07:22:37AM -0800, Andrew Boyer wrote:
>> This bit is defined in the kernel but not displayed by ibv_devinfo.
>>=20
>> Signed-off-by: Andrew Boyer <aboyer@pensando.io>
>> libibverbs/examples/devinfo.c | 3 +++
>> libibverbs/verbs.h            | 1 +
>> 2 files changed, 4 insertions(+)
>>=20
>> diff --git a/libibverbs/examples/devinfo.c =
b/libibverbs/examples/devinfo.c
>> index bf53eac2..e3210f6e 100644
>> +++ b/libibverbs/examples/devinfo.c
>> @@ -220,6 +220,7 @@ static void print_device_cap_flags(uint32_t =
dev_cap_flags)
>> 				   IBV_DEVICE_RC_RNR_NAK_GEN |
>> 				   IBV_DEVICE_SRQ_RESIZE |
>> 				   IBV_DEVICE_N_NOTIFY_CQ |
>> +				   IBV_DEVICE_LOCAL_DMA_LKEY |
>> 				   IBV_DEVICE_MEM_WINDOW |
>> 				   IBV_DEVICE_UD_IP_CSUM |
>> 				   IBV_DEVICE_XRC |
>> @@ -260,6 +261,8 @@ static void print_device_cap_flags(uint32_t =
dev_cap_flags)
>> 		printf("\t\t\t\t\tSRQ_RESIZE\n");
>> 	if (dev_cap_flags & IBV_DEVICE_N_NOTIFY_CQ)
>> 		printf("\t\t\t\t\tN_NOTIFY_CQ\n");
>> +	if (dev_cap_flags & IBV_DEVICE_LOCAL_DMA_LKEY)
>> +		printf("\t\t\t\t\tLOCAL_DMA_LKEY\n");
>> 	if (dev_cap_flags & IBV_DEVICE_MEM_WINDOW)
>> 		printf("\t\t\t\t\tMEM_WINDOW\n");
>> 	if (dev_cap_flags & IBV_DEVICE_UD_IP_CSUM)
>> diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
>> index 7b8d4310..81e5812c 100644
>> +++ b/libibverbs/verbs.h
>> @@ -112,6 +112,7 @@ enum ibv_device_cap_flags {
>> 	IBV_DEVICE_RC_RNR_NAK_GEN	=3D 1 << 12,
>> 	IBV_DEVICE_SRQ_RESIZE		=3D 1 << 13,
>> 	IBV_DEVICE_N_NOTIFY_CQ		=3D 1 << 14,
>> +	IBV_DEVICE_LOCAL_DMA_LKEY	=3D 1 << 15,
>> 	IBV_DEVICE_MEM_WINDOW           =3D 1 << 17,
>> 	IBV_DEVICE_UD_IP_CSUM		=3D 1 << 18,
>> 	IBV_DEVICE_XRC			=3D 1 << 20,
>=20
> This flag really only has meaning for the kernel, it should come out
> of the uapi at all.
>=20
> It is a mistake that kernel internal bits have been mixed in with
> userspace bits.
>=20
> Jason

Isn=E2=80=99t there value in having the userspace tools tell the user =
about a device=E2=80=99s in-kernel capabilities?

-Andrew

