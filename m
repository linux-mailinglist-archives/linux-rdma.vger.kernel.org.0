Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0187493F0E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 18:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356396AbiASR2j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 12:28:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356390AbiASR2f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jan 2022 12:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642613314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rq1qv2Ect/WhWNh9DucygGQEEjr3hYm7KD2ZLMMrMzA=;
        b=OV3gcdZYVVotnkj9c3kSH1BECB+Snk1mZjO9JYdAgwleJppj5UX4JtTw9M10RzhS8B7ntC
        QfncOMeCbpPDujx5lBCHPN5HP3ngSOl2jtIKES+1ffWgdpZPhzYyK75o/LuM0eEIljEhjF
        v3garlc+nZ35MoTorHLQN61sozgUqmc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-vIIPw384OnSkXcMdURWWUw-1; Wed, 19 Jan 2022 12:28:33 -0500
X-MC-Unique: vIIPw384OnSkXcMdURWWUw-1
Received: by mail-qv1-f69.google.com with SMTP id jn6-20020ad45de6000000b004146a2f1f97so3385548qvb.19
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 09:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Rq1qv2Ect/WhWNh9DucygGQEEjr3hYm7KD2ZLMMrMzA=;
        b=gQIl0eSVAWqvJi0tGi79i6cTrBoEKwkTWrS+BkD0jTbvanF/UggaIjm+O7oUeztS6c
         2rY/lwSOTa8M5z6EBRiUnGf8gQZpoy5z1mgoKNnLYF3HtME66H/lams1fbPVC0lbrv3p
         3N6VRx1XgRbyKyrQSX0GUxrgmWxLKjB5moRGhH0IglkmwKzBfzmCdXjxvlQ0IeV0Xdl5
         zLtWn+PezlkYx4E2n2dozxF4Nkz/7Zsu9wdQ3DNIfzXIFt9/0lavDdqPRjRTnnMPuKR1
         fn9f2tQtEoUdLi7TE6ztx9Zk23Hqg6ZFu/XIWhFOYF6YBpNfO4eE/iSFbRG9mTnDNYuv
         0w/g==
X-Gm-Message-State: AOAM532AXdu2utkqBojYRPNPNsgSUmygVoYZ0H3gWwYKSmOqqgga5jUm
        Uti9eo8NDjtW9lZA+cvs/7VRB3HIDc7VjxzadNXvdStwm5DXVIhOW4BucyCe38p8MX5unnioZju
        5BpuHtigfAclVrIt7L1tG+w==
X-Received: by 2002:ac8:5987:: with SMTP id e7mr25222313qte.678.1642613312548;
        Wed, 19 Jan 2022 09:28:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyj17KeZLsR0glbzZbDCytTU0/NJbT35IoJ1Dq7RBQ7S5UbtoXEgPMPUYW+S6pqUy/mTsOKnA==
X-Received: by 2002:ac8:5987:: with SMTP id e7mr25222302qte.678.1642613312328;
        Wed, 19 Jan 2022 09:28:32 -0800 (PST)
Received: from smtpclient.apple (104-15-26-233.lightspeed.rlghnc.sbcglobal.net. [104.15.26.233])
        by smtp.gmail.com with ESMTPSA id q8sm210984qkl.65.2022.01.19.09.28.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jan 2022 09:28:31 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: SoftRoCE and OpenSM
From:   Doug Ledford <dledford@redhat.com>
In-Reply-To: <YefRGdQHkjnzOxuh@unreal>
Date:   Wed, 19 Jan 2022 12:28:30 -0500
Cc:     Christian Blume <chr.blume@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A78C931D-4286-45EC-9F82-818FA7967127@redhat.com>
References: <CAGP7Hd4atpB0J-PP-AC6peiUaD=Y75Fdue9Ab7AS8nkQPwdXvQ@mail.gmail.com>
 <YefRGdQHkjnzOxuh@unreal>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Jan 19, 2022, at 3:51 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Wed, Jan 19, 2022 at 01:41:30PM +1300, Christian Blume wrote:
>> Hello!
>>=20
>> Is it at all possible for a SoftRoCE node to talk to OpenSM? Can I =
set
>> up OpenSM in such a way that it automatically discovers all SoftRoCE
>> nodes on my subnet? Thanks for your help.
>=20
> AFAICT, RXE lacks MAD support which is needed for OpenSM.


All Ethernet based RDMA technologies lack MAD support required for =
OpenSM.  OpenSM is a uniquely InfiniBand only thing.

> Thanks
>=20
>>=20
>> Cheers,
>> Christian
>=20

