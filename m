Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 421AD1888B3
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 16:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgCQPKU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 11:10:20 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:44258 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCQPKU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 11:10:20 -0400
Received: by mail-pf1-f172.google.com with SMTP id b72so12091381pfb.11
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YaaimwD7jmw92Pz/tkejuGphRpIdExzMj05Ty28L9B0=;
        b=PDnbwLHW2Yun3+pc91O5MpzKRkaGHYUOcE5PsOs3gztE1+bhGxAeCDtmbHGnwAu+5P
         kYjutef8en94Smk9WhRawlJ/0el/x+kMAESXgtWSdqQHhMksqT/mJ0oB8zsApwCg9w28
         4I/gY5kRFs6URqdJ33z8ejkB7CuA4GDySYbzMh+Cikm1t2alu9dw567RlVPSOmB6tLnD
         yO0RO6J3pJTTjCvKsgVsDv7T7HOCNjVundI4dpuMAl65pnAXRLIlw7MMB/whWX96y13+
         mhHUOLfsaQkpgWhY4Rc5/7WjXge4HroJrl5++GReBvsX5inkU2Ih+eME3i6AoBCE3MLf
         uvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YaaimwD7jmw92Pz/tkejuGphRpIdExzMj05Ty28L9B0=;
        b=DzUlgQGNhIGGzlH8lrhQpI0KeXu78qrxFSKQV3P2OyhVPuCLqEERca+Kff/4iAnSHn
         lwTnf4bWW7XTitgMmt/lvXI4BpZ9Fmbeb7QDhF1ZgsM/3CE0cBtc2Iyv8cKOo/iLM7LY
         17WrEOYMcLmRl+ypqGK+EGzURo+RjurbheCzfDijexsL0Rmoo/72dzwgfAaO7k6QcmXs
         GmTUKfP3/+VXsk2KSWg01RjF7tXSoxYg++C21V562QMuzAv0q4Ki1NPEl3NETQYPjEYf
         2VTVpiUmmc+6D1ZSgE1oRozNoUoxBWEXL1/HbiagoFGR0sJ8LAeegVUagepQwDnPDHRU
         kfdA==
X-Gm-Message-State: ANhLgQ11vpuxsR/ChFcbH1sO2w+Dsrf0cHUXY/dHKyYDL1apwmNnVJHj
        8CCGnCxVUEaK3zbMorQWu73Q6g==
X-Google-Smtp-Source: ADFU+vsaozV+ufRqCHP+aIcvUD7cltcXJcpNBt2U1m14PA7SU7I0joKD95zIY7CLwYSe6+c/Mhm0Mw==
X-Received: by 2002:a63:350:: with SMTP id 77mr5809126pgd.215.1584457818481;
        Tue, 17 Mar 2020 08:10:18 -0700 (PDT)
Received: from [192.168.4.4] ([107.13.143.123])
        by smtp.gmail.com with ESMTPSA id c201sm3599430pfc.73.2020.03.17.08.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 08:10:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Lockless behavior for CQs in userspace
From:   Andrew Boyer <aboyer@pensando.io>
In-Reply-To: <20200317150057.GJ3351@unreal>
Date:   Tue, 17 Mar 2020 11:10:15 -0400
Cc:     linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F97A8269-872F-4B94-8F03-7A8E26AE0952@pensando.io>
References: <6C1A3349-65B0-4F22-8E82-1BBC22BF8CA2@pensando.io>
 <20200317150057.GJ3351@unreal>
To:     Leon Romanovsky <leonro@mellanox.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Mar 17, 2020, at 11:00 AM, Leon Romanovsky <leonro@mellanox.com> =
wrote:
>=20
> On Tue, Mar 17, 2020 at 10:45:08AM -0400, Andrew Boyer wrote:
>> Hello Leon,
>> I understand that we are not to create new providers that use =
environment variables to control locking behavior. The =E2=80=98new=E2=80=99=
 way to do it is to use thread domains and parent domains.
>>=20
>> However, even mlx5 still uses the env var exclusively to control =
lockless behavior for CQs. Do you have anything in mind for how to =
extend thread_domains or some other part of the API to cover the CQ =
case?
>=20
> Which parameter did you have in mind?
> I would say that all those parameters are coming from pre-rdma-core =
era.
>=20
> Doesn't this commit do what you are asking?
> =
https://github.com/linux-rdma/rdma-core/commit/0dbde57c59d2983e848c3dbd9ae=
93eaf8e7b9405
>=20
> Thanks
>=20
>>=20
>> Thank you,
>> Andrew
>>=20

You are right - I got thrown off by this:

> 	if (mlx5_spinlock_init(&cq->lock, !mlx5_single_threaded))
>                 goto err;

If IBV_CREATE_CQ_ATTR_SINGLE_THREADED is set, it passes an argument to =
the polling function to skip the lock calls entirely. So it doesn=E2=80=99=
t matter that they are still enabled internally.

-Andrew

