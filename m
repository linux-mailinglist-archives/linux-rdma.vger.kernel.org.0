Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02F2486C11
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 22:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244386AbiAFVom (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 16:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244406AbiAFVom (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 16:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641505479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ux/cl9BT3hJuQL+r6FwfCnrQjGYhBVWRziR+0REX2jA=;
        b=MwWU9gKLJ3nodtrrwiK75Dm76ekTDCVTX1MrGPaECyt+jSKwyZLquszqF5LIZ6/cck+/Zz
        +DpnPtgok7jaes1t8GrVR4QglgFsH4jL6JA+bllwCVaOqaFqNWEiVu1kkd5OpF1Dof76Vi
        NM9+85GV9UaLKiiK0EN7x5ihKrZeGao=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-TDfmYARkMe249FY_d4waBw-1; Thu, 06 Jan 2022 16:44:35 -0500
X-MC-Unique: TDfmYARkMe249FY_d4waBw-1
Received: by mail-lf1-f69.google.com with SMTP id g18-20020a05651222d200b0042612bda352so971519lfu.11
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jan 2022 13:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ux/cl9BT3hJuQL+r6FwfCnrQjGYhBVWRziR+0REX2jA=;
        b=PzGvM1X2dFSBEEbkf+RP+3sjkgcjUTDK/d+YncXvKFT3BsGJ4hQrmDILjkBGjI7r5f
         iLBEB58smVnFzre/43JIHHxOpCegEEeAa6qnj9lNx0C+zIq8xJmLnkQWLcy9wUA2qoAV
         EUrpv+FqXzhks9HD0zpVy6ob3CWkwZQ+AgKN908AEhfSw7DLI4gZy16LXme1xNoBDM+w
         rXm88qAr3jPfIgZGqnHoROJlVahRNck1oGB602iwO6AmIB074wQCouD5AjDrRCiBm5/k
         nqsmKdo9twAwG1XcIqYw/rvLSCJ0v5mQhd15mShfvHZJDUOp5LRIsH5NqO1dvq0ENn5G
         p+mg==
X-Gm-Message-State: AOAM530PlDrbluewmW9vySprCFmNr1jydjxCAW2Q0dlV4VdRJkMcD+kt
        3fzPLFjQVYGnI3ldYt9fZ6yuE2SK2TgtAvGZGePSAMA/T4Omzx+cHhVKanwsN4D+jLygPDDlhuP
        C/hFbUuIrEMYeJzN1RlaBO5ZeCktW/x2dDGh5Kg==
X-Received: by 2002:a05:6512:114a:: with SMTP id m10mr51570056lfg.630.1641505473749;
        Thu, 06 Jan 2022 13:44:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2i5J6VzBA/7WeU8Zhj1dOfI0BiA+tdaQF+/6YzclbQyhkm1Vtn8hVLdH/yVEWQgVjR/5F0XcPi0kPdvfz5dk=
X-Received: by 2002:a05:6512:114a:: with SMTP id m10mr51570033lfg.630.1641505473470;
 Thu, 06 Jan 2022 13:44:33 -0800 (PST)
MIME-Version: 1.0
References: <936302652.3678351641496908170.JavaMail.nobody@rsj12rmd002.webex.com>
 <CAGbH50uYd_g9rwvb_3GEHPy=MqErr627cz5CgD1mRa0cbdPD5g@mail.gmail.com>
In-Reply-To: <CAGbH50uYd_g9rwvb_3GEHPy=MqErr627cz5CgD1mRa0cbdPD5g@mail.gmail.com>
From:   Doug Ledford <dledford@redhat.com>
Date:   Thu, 6 Jan 2022 16:43:44 -0500
Message-ID: <CAGbH50top3mvXOGbJqyBES6eOQaOdfQDdrM9JCzmD3ez0qkuuw@mail.gmail.com>
Subject: Fwd: [fsdpwg] Webex meeting invitation: OFA FSDP Webinar Series -
 Deeper Dive Intro & Demo
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Forwarding this here for the people that don't follow the OFA lists.
This service is specifically intended to be available to community
members involved with RDMA development.  If you work for a company
that is an RDMA related company, then you need a company membership in
the OFA to get access.  If you work for an unrelated company (or don't
work for anyone at all), then you qualify for a free individual
membership in the OFA to get access to the FSDP cluster.  If anyone
has problems with the registration link, email me off list and I'll
forward you the invite (I stripped the html portion of the email since
vger doesn't like any html at all, and it mangled the text portion a
bit, so not quite sure how well the link will come through).

---------- Forwarded message ---------
From: Doug Ledford <dledford@redhat.com>
Date: Thu, Jan 6, 2022 at 2:30 PM
Subject: Re: [fsdpwg] Webex meeting invitation: OFA FSDP Webinar
Series - Deeper Dive Intro & Demo
To: <fsdpwg@lists.openfabrics.org>


Hi everyone,

This is the intro webinar for the Fabric Software Development Platform
(FSDP).  This is a new service that the OFA provides.  It is a test
matrix cluster for RDMA and related technologies.  We've mentioned
this cluster a number of times, and this particular webinar will cover
all the essentials necessary to gain access to and use the FSDP
cluster.

We'll be covering:
o Setting up an account on the FSDP cluster
o Accessing the cluster via VPN
o Introduction to the Beaker web management interface
o Checking out and provisioning machines for use
o Logging in to the machines after they have been installed
o Logging in to the build server in the cluster
o Downloading test software to machines that have been provisioned
o More items of interest in the cluster

We look forward to seeing you there.  The presentation will be
recorded and will be accessible in the future from the OFA website or
from the OpenFabrics/fsdp_docs github repo.

On Thu, Jan 6, 2022 at 2:21 PM Working Group Chair <messenger@webex.com> wr=
ote:
>
> Working Group Chair has invited you to a Webex meeting that requires regi=
stration.
>
>
> OFA FSDP Webinar Series - Deeper Dive Intro & Demo
>
> Host: Working Group Chair
> Wednesday, January 12, 2022
> 10:00 AM  |  (UTC-08:00) Pacific Time (US & Canada)  |  1 hr
>
> Register
>

https://openfabrics.webex.com/openfabrics/j.php?RGID=3D3Dr2e24d6a07ce41c2d3=
e052aea6a8744ca

>
>
> Need help? Go to https://help.webex.com
>
>
> =C2=A9 2022 Cisco and/or its affiliates. All rights reserved.   Privacy S=
tatement  |  Terms of Service
>

--=20
Doug Ledford <dledford@redhat.com>
GPG KeyID: B826A3330E572FDD
Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

