Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155D3A690B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2019 14:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfICMye (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 08:54:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60570 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfICMye (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Sep 2019 08:54:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83CsHsW017357;
        Tue, 3 Sep 2019 12:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=JanuEQDpDyfKHacOGdL86wed5q0Np2DCkaRqCFQjv50=;
 b=HlyX/7wpQy4xZKH/u/4r93VyExF19QRIzycEr9QEyjyLCizRdd2WF8OURZtT0xVnLAgc
 VSR6CDMA27YYpRbH4SBQQTf5ncM4Jenu90zuhivWDC8Z6FtX4F1hDkOtUPSq8NIgjsV5
 WQR4N4MYHA+bxmAX9IzPQ325sRB4IxEsa89zkDNYHFjoY1qij+U1Qi83lTCfk4brXxoV
 t9wESFcv5mP5YQlth2gnpkVN2XvCQB7i5r8cbtq47CRJ7zZFz1PwomimkNOLTNKhIBFB
 uZfKrejs71dAH0Dxs3V7BppGc64Huk73pyKLc5wPXxaM4+mQJRSXo4rVLsDbrLZ39DZm IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2usrk2g043-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 12:54:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83Crhms082530;
        Tue, 3 Sep 2019 12:54:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2uryv6ns5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 12:54:30 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83CrxiY032392;
        Tue, 3 Sep 2019 12:54:00 GMT
Received: from [192.168.1.184] (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Sep 2019 05:53:59 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [EXT] Re: qedr memory leak report
From:   Chuck Lever <chuck.lever@oracle.com>
X-Mailer: iPad Mail (16G77)
In-Reply-To: <MN2PR18MB3182C84B8B623A8AE9A7FCBEA1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>
Date:   Tue, 3 Sep 2019 08:53:58 -0400
Cc:     Michal Kalderon <Michal.Kalderon@cavium.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9EE505EA-FA28-40A3-9E83-8EAE260A8FBB@oracle.com>
References: <93085620-9DAA-47A3-ACE1-932F261674AC@oracle.com> <13F323F2-D618-46C3-BE1B-106FD2BEE7F4@oracle.com> <MN2PR18MB3182C84B8B623A8AE9A7FCBEA1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>
To:     Michal Kalderon <mkalderon@marvell.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030136
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Sep 2, 2019, at 3:53 AM, Michal Kalderon <mkalderon@marvell.com> wrote:

>> From: Chuck Lever <chuck.lever@oracle.com>
>> Sent: Friday, August 30, 2019 9:28 PM
>>=20
>> External Email
>>=20
>> ----------------------------------------------------------------------
>>=20
>>> On Aug 30, 2019, at 2:03 PM, Chuck Lever <chuck.lever@oracle.com>
>> wrote:
>>>=20
>>> Hi Michal-
>>>=20
>>> In the middle of some other testing, I got this kmemleak report while
>>> testing with FastLinq cards in iWARP mode:
>>>=20
>>> unreferenced object 0xffff888458923340 (size 32):
>>> comm "mount.nfs", pid 2294, jiffies 4298338848 (age 1144.337s)  hex
>>> dump (first 32 bytes):
>>>   20 1d 69 63 88 88 ff ff 20 1d 69 63 88 88 ff ff   .ic.... .ic....
>>>   00 60 7a 69 84 88 ff ff 00 60 82 f9 00 00 00 00  .`zi.....`......
>>> backtrace:
>>>   [<000000000df5bfed>] __kmalloc+0x128/0x176
>>>   [<0000000020724641>] qedr_alloc_pbl_tbl.constprop.44+0x3c/0x121
>> [qedr]
>>>   [<00000000a361c591>] init_mr_info.constprop.41+0xaf/0x21f [qedr]
>>>   [<00000000e8049714>] qedr_alloc_mr+0x95/0x2c1 [qedr]
>>>   [<000000000e6102bc>] ib_alloc_mr_user+0x31/0x96 [ib_core]
>>>   [<00000000d254a9fb>] frwr_init_mr+0x23/0x121 [rpcrdma]
>>>   [<00000000a0364e35>] rpcrdma_mrs_create+0x45/0xea [rpcrdma]
>>>   [<00000000fd6bf282>] rpcrdma_buffer_create+0x9e/0x1c9 [rpcrdma]
>>>   [<00000000be3a1eba>] xprt_setup_rdma+0x109/0x279 [rpcrdma]
>>>   [<00000000b736b88f>] xprt_create_transport+0x39/0x19a [sunrpc]
>>>   [<000000001024e4dc>] rpc_create+0x118/0x1ab [sunrpc]
>>>   [<00000000cca43a49>] nfs_create_rpc_client+0xf8/0x15f [nfs]
>>>   [<00000000073c962c>] nfs_init_client+0x1a/0x3b [nfs]
>>>   [<00000000b03964c4>] nfs_init_server+0xc1/0x212 [nfs]
>>>   [<000000001c71f609>] nfs_create_server+0x74/0x1a4 [nfs]
>>>   [<000000004dc919a1>] nfs3_create_server+0xb/0x25 [nfsv3]
>>>=20
>>> It's repeated many times.
>>>=20
>>> The workload was an unremarkable software build and regression test
>>> suite on an NFSv3 mount with RDMA.
>>=20
>> Also seeing one of these per NFS mount:
>>=20
>> unreferenced object 0xffff888869f39b40 (size 64):
>>  comm "kworker/u28:0", pid 17569, jiffies 4299267916 (age 1592.907s)
>>  hex dump (first 32 bytes):
>>    00 80 53 6d 88 88 ff ff 00 00 00 00 00 00 00 00  ..Sm............
>>    00 48 e2 66 84 88 ff ff 00 00 00 00 00 00 00 00  .H.f............
>>  backtrace:
>>    [<0000000063e652dd>] kmem_cache_alloc_trace+0xed/0x133
>>    [<0000000083b1e912>] qedr_iw_connect+0xf9/0x3c8 [qedr]
>>    [<00000000553be951>] iw_cm_connect+0xd0/0x157 [iw_cm]
>>    [<00000000b086730c>] rdma_connect+0x54e/0x5b0 [rdma_cm]
>>    [<00000000d8af3cf2>] rpcrdma_ep_connect+0x22b/0x360 [rpcrdma]
>>    [<000000006a413c8d>] xprt_rdma_connect_worker+0x24/0x88 [rpcrdma]
>>    [<000000001c5b049a>] process_one_work+0x196/0x2c6
>>    [<000000007e3403ba>] worker_thread+0x1ad/0x261
>>    [<000000001daaa973>] kthread+0xf4/0xf9
>>    [<0000000014987b31>] ret_from_fork+0x24/0x30
>>=20
>> Looks like this one is not being freed:
>>=20
>> 514         ep =3D kzalloc(sizeof(*ep), GFP_KERNEL);
>> 515         if (!ep)
>> 516                 return -ENOMEM;
>>=20
>>=20
> Thanks Chuck! I'll take care of this. Is there an easy repro for getting t=
he leak ?

Nothing special is necessary. Enable kmemleak detection, then run any NFS/RD=
MA workload that does some I/O, unmount, and wait a few minutes for the kmem=
leak laudromat thread to run.

