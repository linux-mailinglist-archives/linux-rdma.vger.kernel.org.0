Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFC4466A1C
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Dec 2021 20:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhLBTE2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 14:04:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1355930AbhLBTEW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 14:04:22 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2HmSME008350
        for <linux-rdma@vger.kernel.org>; Thu, 2 Dec 2021 19:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : message-id : content-transfer-encoding :
 content-type : mime-version : references; s=pp1;
 bh=1GpQRdmZ5M9wpOANbjXKHLjKnD9SyuTcOl1kfHL5K9o=;
 b=RdLYnXJuhMCcj66SRFzKq3YPy9gb2oy67C5rgfy1JloHCyKh05gDiqBJoxdzTOvAq+WT
 L1jwbURlRJusyH/B7RQ6raB4p2+9FdlQ1FKQtNb0ZLTWJeNwlZigsG5kL8lafrTm6tXJ
 vl31CG9IcGgD2eCHX9YzfHhcrNIoZvv36SuStCzOO2BR8gZK+aDwETkxje6FV/F5wghP
 NlCvMmWKNnAkRHDmA/H7dEYi030IKEdQwjRFA09OGz7bWG4M+PE65/wueznX0ezn3oSu
 gCOwC0xj3bMjkLYfvcJiNhSEmwhy/5xorG03Fnl9W+UrergoKE7oFbhQCbf0cei6WDt0 DQ== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cq2va9jhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 19:00:58 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2IlPLF010108
        for <linux-rdma@vger.kernel.org>; Thu, 2 Dec 2021 19:00:57 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3cnne3cg69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 19:00:57 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2J0uGb43909414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Thu, 2 Dec 2021 19:00:56 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B50B2112073
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 19:00:54 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9707A112083
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 19:00:54 +0000 (GMT)
Received: from mww0301.wdc07m.mail.ibm.com (unknown [9.208.64.45])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 19:00:54 +0000 (GMT)
In-Reply-To: <8d41da04-717e-8116-c091-83393990dd84@acm.org>
Subject: Re: Re: [bug report] blktests srp/011 hang at "ib_srpt
 srpt_disconnect_ch_sync:still waiting ..."
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Bart Van Assche" <bvanassche@acm.org>
Cc:     "Yi Zhang" <yi.zhang@redhat.com>,
        "RDMA mailing list" <linux-rdma@vger.kernel.org>
Date:   Thu, 2 Dec 2021 19:00:51 +0000
Message-ID: <OF4D7FCC28.F58B98B9-ON0025879F.00670323-0025879F.00687303@ibm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <8d41da04-717e-8116-c091-83393990dd84@acm.org>,<CAHj4cs9_ZuMnrP9=E-jP7mBZ87Et1ne0VTfQiQGq284XrbbOnw@mail.gmail.com>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF117   October 6, 2021
X-MIMETrack: Serialize by http on MWW0301/01/M/IBM at 12/02/2021 19:00:52,Serialize
 complete at 12/02/2021 19:00:52
X-Disclaimed: 32751
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zxqZzydQn9wSY17KETk_h1WogpL8V14G
X-Proofpoint-ORIG-GUID: zxqZzydQn9wSY17KETk_h1WogpL8V14G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_12,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020121
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Bart Van Assche" <bvanassche@acm.org> wrote: -----

>To: "Yi Zhang" <yi.zhang@redhat.com>, "RDMA mailing list"
><linux-rdma@vger.kernel.org>
>From: "Bart Van Assche" <bvanassche@acm.org>
>Date: 12/02/2021 07:43PM
>Subject: [EXTERNAL] Re: [bug report] blktests srp/011 hang at
>"ib=5Fsrpt srpt=5Fdisconnect=5Fch=5Fsync:still waiting ..."
>
>On 12/1/21 12:55 AM, Yi Zhang wrote:
>> [root@gigabyte-r120-11 blktests]# use=5Fsiw=3D1 ./check srp/011
>-------------> hang
>
>Hi Yi,
>
>Does this only occur with the siw driver or also with the rdma=5Frxe
>driver?
>
>If this hang occurs with both drivers, how about bisecting this
>issue? I
>have not yet run into this issue with the rdma=5Frxe driver and Linus'
>master
>branch.
>

I can't get it broken for siw nor rxe. Though for rxe is see
quite some

'ib=5Fsrpt receiving failed for ioctx 00000000nnnnnnnn with status 5'

Yi, what is the architecture you are running on?
Maybe you can try switching on dynamic debugging for the siw module
and send me the dmesg trace for the hang? Of course it
will not hang with all the prints ;)

Bernard.

