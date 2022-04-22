Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6931B50BC58
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Apr 2022 17:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449638AbiDVQAu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Apr 2022 12:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449635AbiDVQAt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Apr 2022 12:00:49 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2F45DA66
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 08:57:54 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23MDGrRO007891;
        Fri, 22 Apr 2022 15:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=eCko6nk5tps5bHrRWjYE1PE81Y502ibNWhfGXMNR/zk=;
 b=GbrF6ReRBdCioWTOhpd+FYf10ogigr8n3WEhhb4np5MYlvF4uu5/FYNOSxqBxymRtZbJ
 gKsM0fLoYqAt5Ea2Eud4nOrb2FG8xtk+owUcKhJeaEWx3j9+cfm0AqFxrE9Cet2XXL/0
 V+v+UkR37IXixhBbtAGP/qrsglrepj+Kv+x+yE8VHqgfsTb5ZRKcatkKB7cFkUNf233U
 j5kKRfQQnTLul8fCwOX9yOXSeKq1WIBckAGgbX6xKbWlTzrxl1TPkU8moM7Ibntorahi
 4KccaU8F+aIHam0myYr08OlotYSPHKLsIiqzF6K8r4jH9IYkT9rcqIlkHTrxJ3sFZFP1 6g== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fkvtc1cq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 15:57:46 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 9CE481317A;
        Fri, 22 Apr 2022 15:57:45 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 22 Apr 2022 03:57:31 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 22 Apr 2022 03:57:30 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 22 Apr 2022 03:57:30 -1200
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 22 Apr 2022 03:57:30 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJQ/kmQ+u9yD6u7oIJ+vgFOhvv0P93evzK/Wv+V6KQEBMLnL7N+miLY+7IE9Bojix903ZIVPT+sfnkN7dStz71+X552rbyLYhuVLlQiyA5V6vHfeyaYG7lOSTHEjRDU646vNBfHB66ZRCxvfW+HLb831bVBa60UCF1lC31vNTIOWNVrS8oHMaAGwRfg1UuLC3ThIZUfIn7rjlszFTtFmwNpThqpqJzc1LoP5n5yMsfrNeuUUaG3DKxUfSJOf6hWdKs8HmENHlXT9E6DeCswYbGgZJHLFUFPWscROwm2XVzabGFooFRtB1dd4wLThR5xM1QjN6vc4LKc4W/Xj7AKL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCko6nk5tps5bHrRWjYE1PE81Y502ibNWhfGXMNR/zk=;
 b=lDLIGJ+k/pH/ameK60p9p9cPNFdo95Vq5xCVnTwh+IZS2S2ERWhAlmtW+n5HvIO2fdIX4MPQjWSJp5c4a1cBDwf8+WJUGiq3quHa9edwemlJRDDzY4xD2+qjqjweY6MXpfoC06WqS7nZcH+tWfjbKHnp4MEw6II0dehc4NagTR9NYe81lednWUFqo03G1/h+oShNpd4YHoeAbAa2drvHigfQhim8ZXqY/ilbOBoELUOIU4tHWurHibvPzkhXP9J7ZbY8ODjg3RShxTlfhueOIWc6EqCdP3PLm7cQugGGgq0smVr25BnVlzw7B6UvIyHc4lcuzKjDBkQR02O7JX7GZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by MW4PR84MB1972.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:57:29 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1d3b:32cb:5dca:4e40]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1d3b:32cb:5dca:4e40%5]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:57:29 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Yi Zhang <yi.zhang@redhat.com>
Subject: RE: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by __rxe_add_to_pool
 interrupted by rxe_pool_get_index
Thread-Topic: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by
 __rxe_add_to_pool interrupted by rxe_pool_get_index
Thread-Index: AQHYVfgELlIHvRVE2UGFEx3L0N2mrqz8FvMg
Date:   Fri, 22 Apr 2022 15:57:29 +0000
Message-ID: <MW4PR84MB23078B439AE048978D67F42EBCF79@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220422194416.983549-1-yanjun.zhu@linux.dev>
In-Reply-To: <20220422194416.983549-1-yanjun.zhu@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c715ece-aa4d-4981-860c-08da2478cdb6
x-ms-traffictypediagnostic: MW4PR84MB1972:EE_
x-microsoft-antispam-prvs: <MW4PR84MB19729F6AA86791E20DDBC52CBCF79@MW4PR84MB1972.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmfTV7S4HUlKkjtke6fScdW7l3AvKLdrnrzvW6mHYbdwCeDksGy/8YXZszmZGFjmzFLQYoSwLS4I0rNHlZTpLyp8bQEDb8RVeefN4eLT7Qc/jRmxlp8VGVN0Gvry8IYF0SgtF1nYnILdsA0ybUFmVpBL8+QSTooK5BK0P5Gzr2DKwJ1chqnrULqdb5o7Y8kPo7hLhStXf2ayXuFa2wI5xqtrMxFD9x8akd514abHQ1aJT8AI0kuJss+jPUWC+ear6dKul957NEfgC8cJD4qKSI3C5p24ebilv/tpz0hOE5CZSB3E4HEe//TQA1kMr3bpDtrPBjeNVRVI247zer7VYBjiTn1l+6JUs6gfE5DiqwfzXngeEjx3WHtq/tbG/ARqT/FhP3nSxqdV5WOsUdQqzzR0DwjltAxa/BIm8CdvyIybZSXcckOATMaXz6w6EuvdCT/NO7/dsNRTbdyZ2X8FQRVHQxoGlK5StLamyl9aFX+CFC5aTwlEcJPstl6VX4T2KvESdf0TslzPHYtQWhwRQ0oLSDjQixyNxEZTWdRHS96Nrn6tk0gSjqiEWLXNhitPBIxfr6xBOLmhyUDHgTU2pCW+IoIKZGtvBFg9XBNKQM3ra/HO+nJOg0/pXE/CvD4fII3YTg5iIcySZGug6nkgeqXSQ/C044Z++YFXhY/vJ4qlzGDIWDVOA1XbbfV4aUZVM02ZVj+LzR3KqvMfMT0eFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(6506007)(7696005)(26005)(9686003)(8676002)(71200400001)(55236004)(4326008)(53546011)(122000001)(82960400001)(508600001)(86362001)(66476007)(38070700005)(38100700002)(64756008)(66446008)(5660300002)(83380400001)(66946007)(186003)(52536014)(2906002)(76116006)(8936002)(33656002)(110136005)(66556008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yUO2zwAiVn+h+XAdOsN/fijM1ekpo4RH/HZ+lSx1/I7vh083uXWamLUDp0By?=
 =?us-ascii?Q?ISfwFyoLQxqs6uDVN/bHKwVVks2u3fq11TRVATChC6PbkQ8peDvmTcfSFPjO?=
 =?us-ascii?Q?/BCKfak2Uii1p8sNZc8VcD2m2dhV5NgXuhBIZdZNvnNzblayfMymAwk3bPqO?=
 =?us-ascii?Q?oj9ssJsaSJRnHY2/9f2z14FAPPoO+Hzv2aWt4+PreAgnrgoBCb9pnFRMgnjx?=
 =?us-ascii?Q?PwPnU3aWF0PmrCRvu9hqHlGhUtnPBTTnLhn59kAKGIUoe4hQDQbieSswiPsM?=
 =?us-ascii?Q?U7comQ0Lq1yGYhjy/Zgl/XG5VfS/Vxz/r0JT+NMUgTOc37fw3YebdKnjj3r1?=
 =?us-ascii?Q?MPkS/OcHmClKf9P10Rsy11YFSMcdBq5LeFPOP8Z9VFYC8Xf/shjyDCxBVQ7n?=
 =?us-ascii?Q?rDq098rfZSbszCZD5c4I3qZjoZaXyaHSP5CUaeMhxV2Ql087XM6cH6rMW905?=
 =?us-ascii?Q?wgwTOh7WFsZUfl2P3Zhr2Q4yxEpglFNSc54Wb4tkkLtZZY9N3dWUzfWGsrb9?=
 =?us-ascii?Q?UYMhAL6ejunT9L+EnqV5P5JuqHVdPgNjKRVVl2xzxnXF/cjgRGbpEwlI57wl?=
 =?us-ascii?Q?jvtCIz4fuMGMVTz0m/t9BHlCpAXN82PzRBIHeuzHDbs4eE87+FptWLilFG0n?=
 =?us-ascii?Q?gZSx+gBi9XO4MfgrLf685hXX9qrwP3QtVpzHGkl7sHEx5NMIVbp+3jpj1HcM?=
 =?us-ascii?Q?sDW7UUN42ZOjbBwV65IbNV3OLr29iK0TOWxU1JiK3hc04UwM4ZwMByE4CMhB?=
 =?us-ascii?Q?4P4Dq6P3z+8bfvLFl6ruifR1SRMnOXSsJ/YR8QUWDU4T1bwoPQ6m3GSSJ3LF?=
 =?us-ascii?Q?J0iB0msr0EJv0JVwC8Oc+c6eOr8YX2Hfpd6ia7w9ODyESW5NUjH/0UXrd0Dk?=
 =?us-ascii?Q?PHA1FO4BsEWuV40waEMn3A5DjTq8gbanrEFozCY4qXWf0G/CRmUwPJaMNexQ?=
 =?us-ascii?Q?jgnyNtsGsR3hi22LO+AioEM0TJL7w10xLCNDUzWaFAm6kcKJp1J/+O2C19Wu?=
 =?us-ascii?Q?JacsNT59r1TogwgpajYZ5AQm+/RXmz4SJuoIrp5KfhOd4dIIR/jpUXpAQ4k4?=
 =?us-ascii?Q?Yy+d/4atgZuA6ZO1ZhiQ95eC/bHN8WlVmvA5zyl+rGC9wr3m/mNvDD46MDbE?=
 =?us-ascii?Q?RdTIq3SH8huP/6fkLQB/fO/majrXxchLejxSg3UvwCnpPmRsuNTkqBp5fZOw?=
 =?us-ascii?Q?aIoL7RWxqhTx0hYyg/lR1KZwTc7XBwgdZghwiRu7hXgPhQFUqm+3KADNEQ0y?=
 =?us-ascii?Q?fvCXxbRDfULw3/b3ckb3LFLLLDGwQPuY/Eqm/3nm4+afcmlDnUA7WR3mnYrW?=
 =?us-ascii?Q?QGoC1tJFziXKQ6Bk+7vaIf9nR2G3Niisg7wQE9Z2rEvz87eu8kJLuBtRu9qU?=
 =?us-ascii?Q?hiNWx6kMoSW59W2tig6X6Zfhe8vyJwJt1M4kpMAqq5VonPUArotRXr3MJjCR?=
 =?us-ascii?Q?Dz8LmgZ6u26hpQRt6dOjg+4gB5EbvWt6CgCTAahlE1zRiHucEJVSzNFDcLoq?=
 =?us-ascii?Q?mhZKZ3S/Y8+KfsQQDDPTRQcfmUAWB566uIYC5V8cs3dt6ODec4En9uIzXJRU?=
 =?us-ascii?Q?3aL2x+obsrvw73y0HSV2BPBUmy9IvwOH3l2ejf+oToPJZ+UmsgHY8eGQCyr8?=
 =?us-ascii?Q?q1m35dcya+saGSG0mmf5l2VZWZ2i6iEhdBPfyTSKyw/UPLuEpW+O3RsZ9Ogj?=
 =?us-ascii?Q?cWNKv/VP4tJkVhAhYyh3SmuCD51be1NYV3njoNC5jBSY5iklrQ2QihUSoS7f?=
 =?us-ascii?Q?vA4FoWxc9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c715ece-aa4d-4981-860c-08da2478cdb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 15:57:29.2000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFH0wt96HxZVo1u2RvzZBC/MogNBpPfczlAFIm1SDQYEnFh5HIeIiZWbL16k8aFiCSB82bP0M8Dgg8EhLlQkFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1972
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: hrE7KBs7Po_84yVanwa522zuZbIER-u2
X-Proofpoint-GUID: hrE7KBs7Po_84yVanwa522zuZbIER-u2
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_04,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220070
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use of rcu_read_lock solves this problem. Rcu_read_lock and spinlock on sam=
e data can
Co-exist at the same time. That is the whole point. All this is going away =
soon.

Bob

-----Original Message-----
From: yanjun.zhu@linux.dev <yanjun.zhu@linux.dev>=20
Sent: Friday, April 22, 2022 2:44 PM
To: jgg@ziepe.ca; leon@kernel.org; linux-rdma@vger.kernel.org; yanjun.zhu@l=
inux.dev
Cc: Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by __rxe_add_to_pool =
interrupted by rxe_pool_get_index

From: Zhu Yanjun <yanjun.zhu@linux.dev>

This is a dead lock problem.
The ah_pool xa_lock first is acquired in this:

{SOFTIRQ-ON-W} state was registered at:

  lock_acquire+0x1d2/0x5a0
  _raw_spin_lock+0x33/0x80
  __rxe_add_to_pool+0x183/0x230 [rdma_rxe]

Then ah_pool xa_lock is acquired in this:

{IN-SOFTIRQ-W}:

Call Trace:
 <TASK>
  dump_stack_lvl+0x44/0x57
  mark_lock.part.52.cold.79+0x3c/0x46
  __lock_acquire+0x1565/0x34a0
  lock_acquire+0x1d2/0x5a0
  _raw_spin_lock_irqsave+0x42/0x90
  rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
  rxe_get_av+0x168/0x2a0 [rdma_rxe]
</TASK>

From the above, in the function __rxe_add_to_pool, xa_lock is acquired. The=
n the function __rxe_add_to_pool is interrupted by softirq. The function rx=
e_pool_get_index will also acquire xa_lock.

Finally, the dead lock appears.

        CPU0
        ----
   lock(&xa->xa_lock#15);  <----- __rxe_add_to_pool
   <Interrupt>
     lock(&xa->xa_lock#15); <---- rxe_pool_get_index

                 *** DEADLOCK ***

Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V5->V6: One dead lock fix in one commit
V4->V5: Commit logs are changed.
V3->V4: xa_lock_irq locks are used.
V2->V3: __rxe_add_to_pool is between spin_lock and spin_unlock, so
        GFP_ATOMIC is used in __rxe_add_to_pool.
V1->V2: Replace GFP_KERNEL with GFP_ATOMIC
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/r=
xe/rxe_pool.c
index 87066d04ed18..67f1d4733682 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -106,7 +106,7 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool=
 *pool,
=20
 	atomic_set(&pool->num_elem, 0);
=20
-	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
+	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	pool->limit.min =3D info->min_index;
 	pool->limit.max =3D info->max_index;
 }
@@ -155,6 +155,7 @@ void *rxe_alloc(struct rxe_pool *pool)  int __rxe_add_t=
o_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)  {
 	int err;
+	unsigned long flags;
=20
 	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
 		return -EINVAL;
@@ -166,8 +167,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rx=
e_pool_elem *elem)
 	elem->obj =3D (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
=20
-	err =3D xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
-			      &pool->next, GFP_KERNEL);
+	xa_lock_irqsave(&pool->xa, flags);
+	err =3D __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+				&pool->next, GFP_ATOMIC);
+	xa_unlock_irqrestore(&pool->xa, flags);
 	if (err)
 		goto err_cnt;
=20
@@ -201,7 +204,7 @@ static void rxe_elem_release(struct kref *kref)
 	struct rxe_pool_elem *elem =3D container_of(kref, typeof(*elem), ref_cnt)=
;
 	struct rxe_pool *pool =3D elem->pool;
=20
-	xa_erase(&pool->xa, elem->index);
+	xa_erase_irq(&pool->xa, elem->index);
=20
 	if (pool->cleanup)
 		pool->cleanup(elem);
--
2.27.0

