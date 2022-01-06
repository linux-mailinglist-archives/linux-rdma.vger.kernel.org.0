Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A27486D94
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 00:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245385AbiAFXMm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 18:12:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234795AbiAFXMm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 18:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641510761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ffz5/kDriKyoJOfi8iQ0JjhwpKLyDj+7v2leXIXTx70=;
        b=XhKqw2iZk5sxG0KfSk6EXlb1IBhziEsMU7wkfqYobZXwzyL6Y5r7NQFpD3JL/pJoGD5KWB
        2Hg3CIqr9mmv48QMShahupYVLVEZ4vAGq6ctO4HFu1hL+u5ovySSqM2YimZIVsCwf3t3mb
        GniIzB8AMJFBf8PsyJ9DpoOBZThOB78=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-8n_Dpyf9OyaHXgFDaSLcfQ-1; Thu, 06 Jan 2022 18:12:40 -0500
X-MC-Unique: 8n_Dpyf9OyaHXgFDaSLcfQ-1
Received: by mail-lf1-f70.google.com with SMTP id n7-20020a056512388700b0042a063bb38cso1065085lft.14
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jan 2022 15:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ffz5/kDriKyoJOfi8iQ0JjhwpKLyDj+7v2leXIXTx70=;
        b=7AIkNo50nyHAQRIeFtFENKJBgMDQ+zO6vLCH8LenUrboMH/eouPrCfrg/XlRFmM6xI
         1w+wYyuCu3Yx4XZJnJS3BvBie2NXhSKmAwaPtC1hxjVE0v0SmCCvgufBxjwunQYUScHH
         YKDYQkc7oxJrzK9LTb3VRQTGdLPYc55WWPTBPSpaN/FXbWIe2lPjU7r329256cWQwmij
         oA/4RZi77RsYXwO9qzHM0tSohPN8CmK7ehOVcWi0iHKXOx6PHOqftCgFs50Vqpk/VA0L
         lV07bCwofyqvDn2n8vg5suMQgqdy4pK3ujmXYzM2QMzrgSyF99jutTfuSQUskEE6euC1
         Sg3A==
X-Gm-Message-State: AOAM531bBtHZViHg0fhZ2l9dZgJmGK068U7MTpKv0am0ln56Uj8GVDk0
        Y5rdG85g7+n9KXeSqM9s7Nf/FEARRyeeqxrsigGYSRp83ItKBvT3sXgL4QDmTs8EB8qeZ/3jH37
        8Q1rvqRxZc7b5HVMJwzaVGdIY9qVEWkdh1/dTBA==
X-Received: by 2002:a2e:b616:: with SMTP id r22mr48916742ljn.287.1641510758809;
        Thu, 06 Jan 2022 15:12:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxK1yFP/2pIeHJxAOTmMOV7AW+bvqmDNfZ9+8wfVm7YPNLij204MfhofmO++QjqVIC/T2wSMG7PvMOscaYfXQc=
X-Received: by 2002:a2e:b616:: with SMTP id r22mr48916734ljn.287.1641510758520;
 Thu, 06 Jan 2022 15:12:38 -0800 (PST)
MIME-Version: 1.0
References: <936302652.3678351641496908170.JavaMail.nobody@rsj12rmd002.webex.com>
 <CAGbH50uYd_g9rwvb_3GEHPy=MqErr627cz5CgD1mRa0cbdPD5g@mail.gmail.com> <CAGbH50top3mvXOGbJqyBES6eOQaOdfQDdrM9JCzmD3ez0qkuuw@mail.gmail.com>
In-Reply-To: <CAGbH50top3mvXOGbJqyBES6eOQaOdfQDdrM9JCzmD3ez0qkuuw@mail.gmail.com>
From:   Doug Ledford <dledford@redhat.com>
Date:   Thu, 6 Jan 2022 18:11:49 -0500
Message-ID: <CAGbH50tX-sOmeSiGu-047yO0PidD8pH7HJ2mzJMZaLiVRO-kGQ@mail.gmail.com>
Subject: Re: [fsdpwg] Webex meeting invitation: OFA FSDP Webinar Series -
 Deeper Dive Intro & Demo
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sean Hefty let me know there was a problem with the link in my email.
This one should work:

https://bit.ly/FSDPWebinar_1

On Thu, Jan 6, 2022 at 4:43 PM Doug Ledford <dledford@redhat.com> wrote:
>
> Forwarding this here for the people that don't follow the OFA lists.
> This service is specifically intended to be available to community
> members involved with RDMA development.  If you work for a company
> that is an RDMA related company, then you need a company membership in
> the OFA to get access.  If you work for an unrelated company (or don't
> work for anyone at all), then you qualify for a free individual
> membership in the OFA to get access to the FSDP cluster.  If anyone
> has problems with the registration link, email me off list and I'll
> forward you the invite (I stripped the html portion of the email since
> vger doesn't like any html at all, and it mangled the text portion a
> bit, so not quite sure how well the link will come through).
>
> ---------- Forwarded message ---------
> From: Doug Ledford <dledford@redhat.com>
> Date: Thu, Jan 6, 2022 at 2:30 PM
> Subject: Re: [fsdpwg] Webex meeting invitation: OFA FSDP Webinar
> Series - Deeper Dive Intro & Demo
> To: <fsdpwg@lists.openfabrics.org>
>
>
> Hi everyone,
>
> This is the intro webinar for the Fabric Software Development Platform
> (FSDP).  This is a new service that the OFA provides.  It is a test
> matrix cluster for RDMA and related technologies.  We've mentioned
> this cluster a number of times, and this particular webinar will cover
> all the essentials necessary to gain access to and use the FSDP
> cluster.
>
> We'll be covering:
> o Setting up an account on the FSDP cluster
> o Accessing the cluster via VPN
> o Introduction to the Beaker web management interface
> o Checking out and provisioning machines for use
> o Logging in to the machines after they have been installed
> o Logging in to the build server in the cluster
> o Downloading test software to machines that have been provisioned
> o More items of interest in the cluster
>
> We look forward to seeing you there.  The presentation will be
> recorded and will be accessible in the future from the OFA website or
> from the OpenFabrics/fsdp_docs github repo.
>
> On Thu, Jan 6, 2022 at 2:21 PM Working Group Chair <messenger@webex.com> =
wrote:
> >
> > Working Group Chair has invited you to a Webex meeting that requires re=
gistration.
> >
> >
> > OFA FSDP Webinar Series - Deeper Dive Intro & Demo
> >
> > Host: Working Group Chair
> > Wednesday, January 12, 2022
> > 10:00 AM  |  (UTC-08:00) Pacific Time (US & Canada)  |  1 hr
> >
> > Register
> >
>
> https://openfabrics.webex.com/openfabrics/j.php?RGID=3D3Dr2e24d6a07ce41c2=
d3e052aea6a8744ca
>
> >
> >
> > Need help? Go to https://help.webex.com
> >
> >
> > =C2=A9 2022 Cisco and/or its affiliates. All rights reserved.   Privacy=
 Statement  |  Terms of Service
> >
>
> --
> Doug Ledford <dledford@redhat.com>
> GPG KeyID: B826A3330E572FDD
> Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD



--=20
Doug Ledford <dledford@redhat.com>
GPG KeyID: B826A3330E572FDD
Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

