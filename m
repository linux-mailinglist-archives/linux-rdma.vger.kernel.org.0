Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA391D687A
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2020 16:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEQOzn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 10:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgEQOzn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 May 2020 10:55:43 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C5BC061A0C
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 07:55:42 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so5769995lfb.3
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V3cJi4u95tjfHwn83ydMAu5ED4lmh/UdpFadH2CEgTA=;
        b=ydx4u3oyyKZq7ttX4fbANC6nTBnj96ite4ovq6cwh8XiYT3a2VfBjTAFfeFUz62kks
         d4d3wuaqcNqdJBBsl/g/rAQ/G19tsyG+7KILYy9knjZe/zLiEk//YvHw+asIf/62UNBg
         42wsIhwWj5pVs0bHWBIjJA+djWQlSkWymJFoAr1dryknR4Sg3I2Awghz/h/XIBliuJ4h
         Wg//HeRypGpk2HMsWuw4fdBLvXscaDTpUzH2b9YX62VWqE0mD6nuQqnk0bRMe6dd6d0g
         FVXxR4YHWaZBCFWibIR7hn/CgzHFyYOIEbO/NsuDe09jdaTocBNnH6Yo0UBTn8Kdu5yN
         UYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V3cJi4u95tjfHwn83ydMAu5ED4lmh/UdpFadH2CEgTA=;
        b=khBaNr2c8Uq43r6o1GV6R+gSo+maOC08jT/UoBN+Msr2+63HOUTUW3WLRJ1MyyP6wf
         +U8Ob8PMfaJb6iYMt+XArDhywYkQ2+02nqhUJwxm1ZCUSTnodhqHCtx83X9FNvvCDXuj
         p72STkNjWXWAnb7lXexIFJZoxct2dD1EOZhfVHwmhsa3W7TKuMvcfpXcCS5hNvf/epC3
         JQQhO+lrneId7oJ8YOnk1IbrjCurzg5weufhqcF3Z8OvIaqW/aXU3qpePFaYPxshZK7x
         LowBYjZtvZMXvQ54Cow8GmMeRxnGfapE69dOm6dL9GyaMd6l4IXmlSdVVTbOpDG5+i84
         BOVQ==
X-Gm-Message-State: AOAM530vLcbnGXyFVkSsaYufSkQcpHAJ/c2yuADPQzm2QMs7NNFDKE9o
        5EuTT8VP7Ce0lxTioE0xU/cecg==
X-Google-Smtp-Source: ABdhPJzKwGbfSwSCHEoMI9lBYKeLvwnJwz8Ue8kjb/7gt3blLtNpWy58JFEOGCS7scoE6R4pD7WCGw==
X-Received: by 2002:ac2:53bb:: with SMTP id j27mr8707665lfh.106.1589727341141;
        Sun, 17 May 2020 07:55:41 -0700 (PDT)
Received: from c-46-246-86-74.ip4.frootvpn.com ([46.246.86.74])
        by smtp.gmail.com with ESMTPSA id v126sm2724064lfa.50.2020.05.17.07.55.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 07:55:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
From:   Alexey Lyashkov <umka@cloudlinux.com>
In-Reply-To: <9fe7ac28-4702-d537-a568-c3eb0b5b0ce3@gmail.com>
Date:   Sun, 17 May 2020 17:55:36 +0300
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Israel Rukshin <israelr@mellanox.com>, sagi@grimberg.me,
        jgg@mellanox.com, linux-rdma@vger.kernel.org, dledford@redhat.com,
        sergeygo@mellanox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <EED82DEB-0CB7-41B8-9235-3541D6DD46CA@cloudlinux.com>
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal> <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
 <49391e02-803b-f705-b00e-e48efd278759@mellanox.com>
 <0C22D41B-89CD-4B2D-B514-8EA06F2233D7@cloudlinux.com>
 <9fe7ac28-4702-d537-a568-c3eb0b5b0ce3@gmail.com>
To:     Sagi Grimberg <sagigrim@gmail.com>
X-Mailer: Apple Mail (2.3445.9.5)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It can be issue with one or more Mellanox FW. My own CX3 was work fine, =
but I have reports where it don=E2=80=99t work.=20
Same implementation - but different FW.

I can refresh a memory to found a reports in case someone have =
interested.


> 17 =D0=BC=D0=B0=D1=8F 2020 =D0=B3., =D0=B2 11:35, Sagi Grimberg =
<sagigrim@gmail.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>=20
>=20
>=20
> On 5/14/20 3:09 AM, Alexey Lyashkov wrote:
>> CX3 with fast registration isn=E2=80=99t stable enough.
>> I was make this change for Lustre for year or two ago, but it was =
reverted by serious bugs.
>=20
> This must be issues with the Lustre implementation, all the rest of =
the ULPs (almost) default
> to FRWR.

