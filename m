Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81697287554
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgJHNlw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 09:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbgJHNlv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 09:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602164510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WD+30Sd20j8+rOxJRDo638HMaE+Re/R6ZquXxyVZL/0=;
        b=IqqRTc8aUOKAtxrevwq9h+YOh8/728RLyCoNeAqeJudhI0rpEtmxv8QloosbBSADYSABUc
        lCpevITGi0d8CJN30w/cE3E1BSK1pVKh57jMs9ZcQolOOa1Ft8lhCRfgFzbEW/xElTQP/L
        czGRYmm1q3ZSstFmKRggaP1WfFzPd5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-1XWT2CJzOH2YnraPTKlo9w-1; Thu, 08 Oct 2020 09:41:46 -0400
X-MC-Unique: 1XWT2CJzOH2YnraPTKlo9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAD459CC21;
        Thu,  8 Oct 2020 13:41:37 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2C8919C4F;
        Thu,  8 Oct 2020 13:41:37 +0000 (UTC)
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 90DC918095FF;
        Thu,  8 Oct 2020 13:41:37 +0000 (UTC)
Date:   Thu, 8 Oct 2020 09:41:37 -0400 (EDT)
From:   Doug Ledford <dledford@redhat.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Joe Balich <jbalich@nereus-worldwide.com>
Message-ID: <983756542.53009536.1602164497522.JavaMail.zimbra@redhat.com>
In-Reply-To: <0d3afe23-874b-5b9d-b4b0-62d497610d78@gmail.com>
References: <252007469.52861641.1602078881249.JavaMail.zimbra@redhat.com> <0d3afe23-874b-5b9d-b4b0-62d497610d78@gmail.com>
Subject: Re: Upcoming OpenFabrics Alliance Webinar
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.10.110.57, 10.4.195.13]
Thread-Topic: Upcoming OpenFabrics Alliance Webinar
Thread-Index: 17UEucqvJ7+luIO+VSig2lRmPnf/5g==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Absolutely.  Joe, can we make sure this is done please?

----- Original Message -----
> "Date/Time: Tuesday, October 13, 2020, at 10 a.m. Pacific"
>=20
> This is Beijing time about 1 am.
> Can we record this meeting and share it?
>=20
> Thanks
> Zhu Yanjun
>=20
> On 10/7/2020 9:54 PM, Doug Ledford wrote:
> > Hi all,
> >
> > Next week at 1pm EDT is a webinar about the new Fabric Software Develop=
ment
> > Platform (FSDP).  This is a high level presentation about what we are
> > doing.  This is in line with the new testing program we discussed at th=
e
> > 2019 OFA workshop.
> >
> > I *strongly* encourage any upstream maintainers related to RDMA to atte=
nd
> > (that would be kernel maintainers, rdma-core maintainers, libfabric, uc=
x,
> > openmpi, etc. maintainers).  The FSDP is intended to run CI testing of
> > both upstream kernel and user space projects related to RDMA technologi=
es
> > (it need not be a direct RDMA technology, but one that RDMA interacts w=
ith
> > is sufficient to qualify, so NVMe because of NVMEoFabrics is a qualifie=
d
> > upstream project for the cluster to run CI on).  As an upstream
> > maintainer, this is your opportunity to see where the cluster design is
> > going and have input into the how the cluster is built.  Keep in mind t=
hat
> > hardware has already started to arrive, so this is a case of "speak now=
,
> > or suck it up".
> >
> > Also, the cluster is intended to be a place where upstream developers t=
hat
> > might have access to limited types of RDMA hardware (Hi Chuck!), but wh=
o
> > wish to be able to test across a much broader suite of hardware could l=
og
> > into the cluster and run their tests.  Upstream developers who work for
> > companies that are members of the OFA are automatically qualified for a=
n
> > account on the FSDP.  However, upstream developers working for companie=
s
> > unrelated to RDMA technologies, but who none-the-less end up working on
> > stuff that touches the RDMA stack anyway (Hey HCH!) are also eligible f=
or
> > free individual memberships in the OFA, which grants them eligibility f=
or
> > an account on the FSDP so they too can test their code before sending i=
t.
> >
> > The presentation next week is fairly high level and does not get too de=
ep
> > into the details of the structure of the FSDP.  This is because the FSD=
P
> > is just now being built (the first orders for hardware have been placed=
,
> > servers that control the cluster have been built, now we are starting t=
o
> > build the cluster out) and we still have some flexibility in how things
> > are designed as a result.  This is the upstream community's opportunity=
 to
> > make sure their voice is heard in regards to that design.
> >
> > I look forward to seeing all of you there, and don't forget to register=
 so
> > we can make sure the webinar is sized sufficiently for the number of
> > attendees.
> >
> > Doug Ledford
> >
> >
> >
> > ------------  Begin forwarded message  ------------------
> > New OFA Webinar
> > Introduction to OFA=E2=80=99s Fabric Software Development Platform (FSD=
P)
> > October 13 at 10 a.m. Pacific
> > One Week Remaining to Register
> > http://bit.ly/OFAWebinarFSDP
> >
> >  =20
> >
> > As a reminder, the OpenFabrics Alliance (OFA) will host a webinar
> > highlighting the new Fabric Software Development Platform (FSDP). This
> > webinar is an ideal opportunity for the OFA Community to learn about th=
e
> > new FSDP program, the FSDP Working Group charter and target objectives,
> > which was highlighted in recent a recent OFA blog series (Part 1, Part =
2).
> >
> > Date/Time: Tuesday, October 13, 2020, at 10 a.m. Pacific
> >
> > Registration:  http://bit.ly/OFAWebinarFSDP
> >
> > Presenters: OFA FSDP Co-Chairs Tatyana Nikolova of Intel Corporation an=
d
> > Doug Ledford of Red Hat, Inc.
> >
> > Title: Introduction to OFA=E2=80=99s Fabric Software Development Platfo=
rm (FSDP)
> >
> > About: The new Fabric Software Development Platform (FSDP) project is a
> > vendor-neutral cluster owned and maintained by the OFA for the benefit =
of
> > its members to develop, test, and validate new and existing network
> > technologies. FSDP offers OFA members an opportunity for serious cost
> > reduction in testing, validation, and development, and provides an
> > invaluable service to the open source community of maintainers as they
> > support open source networking software integration.
> >
> > In this webinar, OFA FSDP Co-Chairs Tatyana Nikolova of Intel Corporati=
on
> > and Doug Ledford of Red Hat, Inc. will cover:
> >
> >      Origins of FSDP Project
> >      Introduction to FSDP Usages
> >          Continuous Integration Testing Service
> >          On-Demand Development and Testing Program
> >          Logo Testing
> >      How to Join / Contribute
> >
> > Please contact press@openfabrics.org with any questions.
> >
> >
>=20
>=20

--=20
Doug Ledford <dledford@redhat.com>
              GPG KeyID: 0E572FDD

