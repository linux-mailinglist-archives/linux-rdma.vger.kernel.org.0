Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F38228608F
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Oct 2020 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgJGNyz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 09:54:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728526AbgJGNys (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 09:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602078885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=83V1503E1Au2YwuNcpFE2I7JcBpY77JP+Cmbo9VJuNo=;
        b=A0MaaJ6MG9FpvOeclFPJWbsGeb0msgifXW8ojb00CPWMFyOUoOPKXMkm3sDCkJyRmegEXa
        RoEXsWHEBZcDZEMUR6TUX7+Cb0tyLWwJzI57t2+IAwFJSk7VX07hUkHFi0l21yMZzqxtOW
        bLulBCmZWdbQp+0OCGwg4xWPCIA9LOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-Tne8v-ocMEK17rTTu4G6cQ-1; Wed, 07 Oct 2020 09:54:42 -0400
X-MC-Unique: Tne8v-ocMEK17rTTu4G6cQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73D29192AB69
        for <linux-rdma@vger.kernel.org>; Wed,  7 Oct 2020 13:54:41 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D2F91001281
        for <linux-rdma@vger.kernel.org>; Wed,  7 Oct 2020 13:54:41 +0000 (UTC)
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 674DB181A71E
        for <linux-rdma@vger.kernel.org>; Wed,  7 Oct 2020 13:54:41 +0000 (UTC)
Date:   Wed, 7 Oct 2020 09:54:41 -0400 (EDT)
From:   Doug Ledford <dledford@redhat.com>
To:     linux-rdma@vger.kernel.org
Message-ID: <252007469.52861641.1602078881249.JavaMail.zimbra@redhat.com>
In-Reply-To: <431809995.52859932.1602077964742.JavaMail.zimbra@redhat.com>
Subject: Upcoming OpenFabrics Alliance Webinar
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.10.110.57, 10.4.195.17]
Thread-Topic: Upcoming OpenFabrics Alliance Webinar
Thread-Index: sBTAlMhyXBv/OYqksa3XE6ydgkMaxg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

Next week at 1pm EDT is a webinar about the new Fabric Software Development=
 Platform (FSDP).  This is a high level presentation about what we are doin=
g.  This is in line with the new testing program we discussed at the 2019 O=
FA workshop.

I *strongly* encourage any upstream maintainers related to RDMA to attend (=
that would be kernel maintainers, rdma-core maintainers, libfabric, ucx, op=
enmpi, etc. maintainers).  The FSDP is intended to run CI testing of both u=
pstream kernel and user space projects related to RDMA technologies (it nee=
d not be a direct RDMA technology, but one that RDMA interacts with is suff=
icient to qualify, so NVMe because of NVMEoFabrics is a qualified upstream =
project for the cluster to run CI on).  As an upstream maintainer, this is =
your opportunity to see where the cluster design is going and have input in=
to the how the cluster is built.  Keep in mind that hardware has already st=
arted to arrive, so this is a case of "speak now, or suck it up".

Also, the cluster is intended to be a place where upstream developers that =
might have access to limited types of RDMA hardware (Hi Chuck!), but who wi=
sh to be able to test across a much broader suite of hardware could log int=
o the cluster and run their tests.  Upstream developers who work for compan=
ies that are members of the OFA are automatically qualified for an account =
on the FSDP.  However, upstream developers working for companies unrelated =
to RDMA technologies, but who none-the-less end up working on stuff that to=
uches the RDMA stack anyway (Hey HCH!) are also eligible for free individua=
l memberships in the OFA, which grants them eligibility for an account on t=
he FSDP so they too can test their code before sending it.

The presentation next week is fairly high level and does not get too deep i=
nto the details of the structure of the FSDP.  This is because the FSDP is =
just now being built (the first orders for hardware have been placed, serve=
rs that control the cluster have been built, now we are starting to build t=
he cluster out) and we still have some flexibility in how things are design=
ed as a result.  This is the upstream community's opportunity to make sure =
their voice is heard in regards to that design.

I look forward to seeing all of you there, and don't forget to register so =
we can make sure the webinar is sized sufficiently for the number of attend=
ees.

Doug Ledford



------------  Begin forwarded message  ------------------
New OFA Webinar
Introduction to OFA=E2=80=99s Fabric Software Development Platform (FSDP)
October 13 at 10 a.m. Pacific
One Week Remaining to Register
http://bit.ly/OFAWebinarFSDP=20

=20

As a reminder, the OpenFabrics Alliance (OFA) will host a webinar highlight=
ing the new Fabric Software Development Platform (FSDP). This webinar is an=
 ideal opportunity for the OFA Community to learn about the new FSDP progra=
m, the FSDP Working Group charter and target objectives, which was highligh=
ted in recent a recent OFA blog series (Part 1, Part 2).=20

Date/Time: Tuesday, October 13, 2020, at 10 a.m. Pacific

Registration:  http://bit.ly/OFAWebinarFSDP=20

Presenters: OFA FSDP Co-Chairs Tatyana Nikolova of Intel Corporation and Do=
ug Ledford of Red Hat, Inc.

Title: Introduction to OFA=E2=80=99s Fabric Software Development Platform (=
FSDP)

About: The new Fabric Software Development Platform (FSDP) project is a ven=
dor-neutral cluster owned and maintained by the OFA for the benefit of its =
members to develop, test, and validate new and existing network technologie=
s. FSDP offers OFA members an opportunity for serious cost reduction in tes=
ting, validation, and development, and provides an invaluable service to th=
e open source community of maintainers as they support open source networki=
ng software integration.=20

In this webinar, OFA FSDP Co-Chairs Tatyana Nikolova of Intel Corporation a=
nd Doug Ledford of Red Hat, Inc. will cover:

    Origins of FSDP Project
    Introduction to FSDP Usages
        Continuous Integration Testing Service
        On-Demand Development and Testing Program
        Logo Testing
    How to Join / Contribute=20

Please contact press@openfabrics.org with any questions.


--=20
Doug Ledford <dledford@redhat.com>
              GPG KeyID: 0E572FDD

