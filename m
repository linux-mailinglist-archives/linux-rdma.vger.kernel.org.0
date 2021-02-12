Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6970731A1A5
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 16:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBLP1T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 10:27:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231865AbhBLP1R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Feb 2021 10:27:17 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11CFLFUG017783
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 10:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=ewYpEukUeHO9O7FQh4ZbbipaK8gJRiXpzPE0f62YjA0=;
 b=m+L4l98jaEuTHUB0XcPBsVEpIrWZEUiEHD+sUjO6isM+GJsqVWUzueOzngrv/HsK6L19
 SEEKF9dGpGihl46P6ZFdiBj+OQ+M3MbusNCFb/1wERoYdb7FYxulWvxKZPwt7c2aG8ki
 79k6xDwfEXJ1GKD/SAhLSlMd2IAhYJ3ucxXCwe9nA6RZwmDLZmPQ18uJuLqFEIqRyDV0
 9mPvlHvQmVbwSJOVjVYOzqWvgGMHoVYZVE1GkENElVduQsfCvWzQgspgojCGp7GZj8aL
 laubkor0BJjh17UcQXyO7kkunZOp+aJkvzs0d97lYmhtZ+JNHD3MAnik/Rd9bS/cnrLh fw== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nv8a836x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 10:26:33 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 12 Feb 2021 15:26:32 -0000
Received: from us1b3-smtp05.a3dr.sjc01.isc4sb.com (10.122.203.183)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 12 Feb 2021 15:26:30 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp05.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021021215263012-383032 ;
          Fri, 12 Feb 2021 15:26:30 +0000 
In-Reply-To: <42736765-35DA-454E-AF9B-0484D98C821A@redhat.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Benjamin Coddington" <bcodding@redhat.com>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Fri, 12 Feb 2021 15:26:29 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <42736765-35DA-454E-AF9B-0484D98C821A@redhat.com>,<4B1D8641-3971-409C-B730-012EDE4D3AEB@oracle.com>
 <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
 <OFE25AAD0A.3B8CE2E0-ON0025867A.0043F201-0025867A.00455111@notes.na.collabserv.com>
 <OFCA489C99.24705C66-ON0025867A.004929F2-0025867A.004929F9@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: 6479A795:E0C17A4D-0025867A:0054D29B;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 46175
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21021215-1639-0000-0000-0000035F262B
X-IBM-SpamModules-Scores: BY=0.025629; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.012553
X-IBM-SpamModules-Versions: BY=3.00014728; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01506756; UDB=6.00813480; IPR=6.01289299;
 MB=3.00036114; MTD=3.00000008; XFM=3.00000015; UTC=2021-02-12 15:26:31
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-02-12 14:36:07 - 6.00012297
x-cbparentid: 21021215-1640-0000-0000-0000C8A5ACB8
Message-Id: <OF6479A795.E0C17A4D-ON0025867A.0054D29B-0025867A.0054D2A4@notes.na.collabserv.com>
Subject: RE: directing soft iWARP traffic through a secure tunnel
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_05:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Benjamin Coddington" <bcodding@redhat.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Benjamin Coddington" <bcodding@redhat.com>
>Date: 02/12/2021 02:27PM
>Cc: "Chuck Lever" <chuck.lever@oracle.com>, "linux-rdma"
><linux-rdma@vger.kernel.org>
>Subject: [EXTERNAL] Re: directing soft iWARP traffic through a secure
>tunnel
>
>On 12 Feb 2021, at 8:19, Bernard Metzler wrote:
>
>> How does this tunnel device look like? What does
>> ifconfig or ip show? Probably NOARP and no
>> HW address?
>
>right:
>
># ip link show tun0
>3: tun0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER=5FUP> mtu 1500 qdisc=20
>fq=5Fcodel state UNKNOWN mode DEFAULT group default qlen 500
>
># ifconfig tun0
>tun0: flags=3D4305<UP,POINTOPOINT,RUNNING,NOARP,MULTICAST>  mtu 1500
>         inet6 fe80::6bbf:1def:b134:2eef  prefixlen 64  scopeid=20
>0x20<link>
>         inet6 fd51:5f56:d79b:a64e:64cc:5641:2916:7c4  prefixlen 64 =20
>scopeid 0x0<global>
>         unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00 =20
>txqueuelen 500  (UNSPEC)
>         RX packets 751  bytes 118096 (115.3 KiB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 781  bytes 124142 (121.2 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>
>> Or should I better setup a VPN client to your network
>> to see what is needed?
>
>I can provide you with an openvpn config file that you can use to=20
>connect to
>our network under separate cover if you'd like.
>
great.
let's take this off the list and come back with a
proposed 3 lines patch. But, actually, I hope we
do not see problems with the iwcm regarding address resolution.

Best,
Bernard.

