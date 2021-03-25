Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1F73497FC
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 18:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhCYR0v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 13:26:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39190 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhCYR0X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 13:26:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PHPDhB125691;
        Thu, 25 Mar 2021 17:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nFOP0K1SEgEH4zgQItHDNqnht7QYGNZeRGRlnK1Cp78=;
 b=UhDrBR2jNNpy4Tyg/B92BEID/+hDbWkFKd9lD+QP8y3IU1gpzvNOZRySi8zQCRfz/97u
 kIORF5sTIyBijBnh05g0JUAo2p+24cBAd2sg/KkAYAR2kmIiMwlYd3pHLh1NDNGWPUXw
 OWJjqZT55hCNFan4eAtCfpuEg73B6/Xveag4us3c4gs542ZQNbsUEgApOBWGj465roj8
 skMyYFo5PP5ZAZbcE+HxOTVlT/FTP3gQ3N42x/EzXirZJjbolczPjh3EI7bXym5Dc3QA
 RfvFKUgQSpeRw8K4rV5CIrSsALhrCPqtbFipqxwbGtivY5GxIS/F1lVak4N8S+YouUTa kQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37d8frf53u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 17:26:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PHQGCc040616;
        Thu, 25 Mar 2021 17:26:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by userp3020.oracle.com with ESMTP id 37dttuy6ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 17:26:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdrXebO+OHW/nzgIZFGYuvgQIlpNd/6gOxcmqbtbUgyftQvFNlD5hgttxst3sUt7x3KRWDrkBBN9JLFrTEgRTphMqnX6ZoylndlwCloRPXEBkf/3X01y0Q+z1lTcu53rHb1vbGX4T+me0lKkFriIhVySc3viWM9yp6PyNI9jjGfEBMuaEjnYZJ5zME0fQkDXRchBmfN0qRQFqQiEdCq2IZWrlGkJUliq+6uQp9SKoDeIzfZ4tLoa0qCwD8XzK5K78o3vhsBWL/oSq7A/Glj8R75AgBhAipxws+2ZbG9KSSIgwWD1ckCgY4MkWqioUaMJKnkkwj7Fdr1ZXVQpCgDX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFOP0K1SEgEH4zgQItHDNqnht7QYGNZeRGRlnK1Cp78=;
 b=I0vFbwufpbze07CgYTaSHP+qqcpaOz2SbGCrCW0QIfRZAQUouodIcCnzpOZlzUclkU3VfBxr5wknO/gUXkYsKIGL/cwJz55dzunYPhWxfkLmufD+sa01mklTYI6Nydd9h3cy7L8Tx9bGw87aNHtbll5nIJz6frQtOVK9OmzQ4FUInqff/PFQiUd8tNA+Z77zk6PPi6qk7NfyZs1eAOrHO0qfhEsaKDOhz7nRPjNF7tqTiVA32RW7ePLcUb7KXNA8UqGyUGT/yZPDDhE9ryJdXocW6y/wPFPcotNMCVXkgG21SfoRkJQlvLAzmjJlKHOFVi1nAkKRwcq5o26uNlRB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFOP0K1SEgEH4zgQItHDNqnht7QYGNZeRGRlnK1Cp78=;
 b=QfkjlJn7gKk2HvDsFAH5fm/BQxmuj+Fh+FBthGYQ1WPpvrRbgqNd+EdBrmFzLgzmCntjGU7zf6MwonhOe9fSxtUF5/aDKQs2bepyrQ1uGSgWf5UZJN/rph46QDwr1kholvGDFUR9B04qSLNk7zvjyh5+yyHXyPe4tiqPGlPpUcw=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2965.namprd10.prod.outlook.com (2603:10b6:a03:90::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 25 Mar
 2021 17:26:05 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 17:26:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     linux-rdma <linux-rdma@vger.kernel.org>
CC:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>
Subject: Re: FastLinQ: possible duplicate flush of FastReg and LocalInv
Thread-Topic: FastLinQ: possible duplicate flush of FastReg and LocalInv
Thread-Index: AQHXGp6rQmS73ds8r02HG2jW0ooLiaqIS08AgAA5HgCADH40gA==
Date:   Thu, 25 Mar 2021 17:26:05 +0000
Message-ID: <832708D9-C956-4777-B904-8CE2114DDA37@oracle.com>
References: <73EEB368-3E02-4BDD-BE16-4AA9A87A3919@oracle.com>
 <039DFCA1-84BE-4043-8136-423055A12796@oracle.com>
 <b2114710-10d7-eadc-01dd-94d1f862a99e@talpey.com>
In-Reply-To: <b2114710-10d7-eadc-01dd-94d1f862a99e@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60c72a13-b2b4-49f6-d805-08d8efb31220
x-ms-traffictypediagnostic: BYAPR10MB2965:
x-microsoft-antispam-prvs: <BYAPR10MB2965F0A6AFBC9C5F9066E41193629@BYAPR10MB2965.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y3TQB2Z5VWJKe4DEf9JD2rYgHc0/hvzwF3ofT7VhUL/az7DfxYmE6ZpgZYCSKHvgF5b/J6v0uLqSTFmKLOK+f2iu8HSv7UBUjzinfVc5nEPxBShgNO4cXRgXKRYKZ0CM3htoMyRjv+LUBnOr9JVrug4SxE1wlorqdF2254ZER494kE+1p5rr9xxsTZLCD42s0A6nDnOQC8o8LPGODPCWO/L/LVoA/qEYgPy9NrU6XzcoZR2nvjE3SLLsGzBk/MnLbmd8B7ladHYmiUDbOiAY13iU+EClVYKc7+7OF/XI3E1KqSCiEytSQoRsX2yHLbENwjDdTjLcxI7tk8hSgQ5/unbPfPw7PWYcubtxK88Pojw3PmsgWorHyLSyPf41VMggOaCYCw4AvwnZKUzZ1T4G4ZrT7NuLsbGy+rolijWmHKKV4sUdSvVUXy55TFbjw5z2U2d1LQ4uHd+OlDaQweScQ5Likg36g4R8BCrBQE4sIIrDBy65eOVSbWILQYeZWmhItiuIElm66E96lDU/Dj46PNWuKrB9/FvhQbsvBdOdm8HglOplXZlOEB7s0Rp8pgJeyBbmSwI1QHYzdLLRVxCEIT0KYUbc1cGrKfEDQYsespbF2K4mDtuRDRvIjv/N08Yo57o62SURA9T2swVvfU5ZGTvXzEfQrjxzLETvgAxc8iyuuSPn7MPNUOzZzH90bWXK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(39860400002)(346002)(4326008)(26005)(6506007)(2616005)(86362001)(8676002)(36756003)(53546011)(8936002)(6512007)(186003)(83380400001)(38100700001)(33656002)(66446008)(2906002)(91956017)(54906003)(5660300002)(66476007)(66556008)(64756008)(71200400001)(76116006)(6486002)(66946007)(6916009)(478600001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JbqgeqR/9bOsEHFccVgrvF8TlJf5MkvmLv2FpH7p4Rl9gWT3jZ3fuKYw0lxG?=
 =?us-ascii?Q?g63DiOgwy3z+A4SlD4pOe15C0gw2Q0b5d2B4rrtoOfTTVQGSzJ/BE9CAxiC7?=
 =?us-ascii?Q?6F24eZcLIZiZpDyhtWgnw9/O+qaqmwHGBhaDznG6DyBDJ2ej+nsT2DotgpXf?=
 =?us-ascii?Q?wivBTVq1IOhwn4z82owCOzjAU9GH3cwMwEBF7QPO2jqvf3rBPCv2MZdgYgBm?=
 =?us-ascii?Q?yYf2al3uMSqoTv+4ukyaxzbe00UyM77e3ZHLZqop34x4DyPcPz2UaryJbuaC?=
 =?us-ascii?Q?HCvoN3SVO7Ny5OEFtmQZLfldv/Ib1iq6UAjYVln3nVgx3yJM2jT/Fl5apidq?=
 =?us-ascii?Q?z+g4RFOe+B11Vh+u0WQuoaawUjV2pUDtYCq/EgIeJpTpnsExuJJKR1h6c8f1?=
 =?us-ascii?Q?LZRu17VH2K30mRYg6MMeWwGsr+9ie3R/4eNFA/Cv+VwMoN3rYkxEvKz4b0Pz?=
 =?us-ascii?Q?p877DJYS+iU7QITtML6Nqdu0+E2VrzEK0zYFNtbgnQufEZl8mPykot/RlIFz?=
 =?us-ascii?Q?oAekNJuc4Ccq2rANcIWd8Mc5Hp/cf5yY41YY5ejnEkc7LuQGsx192KISZ0aR?=
 =?us-ascii?Q?Om3ASx5PWvoYpCdmFCYB/43ayiEw3TQ3hyIGlNJGYtFX9cNHvRY7RDGq8zhr?=
 =?us-ascii?Q?orWX5r/vtcUPW18YlLcg9XcLbI/HqAoR2bsYUvRxdBaqNjBYhnI+zPKe6Cjj?=
 =?us-ascii?Q?fxNQb+w2lB+Ujh6llmc5nBZnBT171ELiB0SWpZDTg5rGoSdUy7a8Z+UE7UqH?=
 =?us-ascii?Q?KgVonPPSVOIpxbwIGepnLEldMQ13xDRb16PdX/BKTXpeL+r+utpFDxFqPZQ+?=
 =?us-ascii?Q?Zr4i8Xsuvwph/c7SxmvcSMlG5Cd9YFwMpNnHIZIft5HVwfGxIW+EPxrVzLUD?=
 =?us-ascii?Q?HNPXQjM+t4Tq/6vdzVWFZP0WZj8J72Qfodl2p5L+DXS6Qcx5scphlyg524lR?=
 =?us-ascii?Q?gChsJYtdVX28RXRypjxqEjLM1Azagk4knuyUxsOQK54uYnNueadw9YkrLp+q?=
 =?us-ascii?Q?UKTnB6rBvOB/+epyyeXijnytYZZLNAxgcnAD3j//kDdrkBEmjb+j0Hdwo11l?=
 =?us-ascii?Q?j6+S/k7rXP/5bg91sr5Fsvx4IMkY+47PUAeO4WxeiJTDy6lAJDQ0T6MidZHX?=
 =?us-ascii?Q?jO3RyRVDmD6vncV6bFSLT+KNIywAHXH62J7G+rmsPB56RC3etFp0orZr38lA?=
 =?us-ascii?Q?AizEe0WxAI1lRKHE7PuTLgOFu7RqEC98qKIG/jfDUFV4LWtsQeTkJE8nW+r2?=
 =?us-ascii?Q?W2UbXbRATA5Mju5nkD8fSHDRgXgWVwCm5Yp2+f0nULKEiJ4/eqhIkPdMHN1b?=
 =?us-ascii?Q?LWZApnKwkNnlQK0CMHwlRf39?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D02B9947369F04BA07591184886C606@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c72a13-b2b4-49f6-d805-08d8efb31220
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 17:26:05.4435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jncfyxbutaToC0oAfE4MzXIfoKGfZr8l5WYWYejZNHAltzBPn5CsQeogu0p7reK6Ud6rz0MnBgoAZrBOrCEW8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2965
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250127
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250127
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Mar 17, 2021, at 2:39 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 3/17/2021 11:14 AM, Chuck Lever III wrote:
>>> On Mar 16, 2021, at 3:58 PM, Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>>=20
>>> Hi-
>>>=20
>>> I've been trying to track down some crashes when running NFS/RDMA
>>> tests over FastLinQ devices in iWARP mode. To make it stressful,
>>> I've enabled disconnect injection, where rpcrdma injects a
>>> connection disconnect every so often.
>>>=20
>>> As part of a disconnect event, the Receive and Send queues are
>>> drained. Sometimes I see a duplicate flush for one or more of
>>> memory registration ops. This is not a big deal for FastReq
>>> because its completion handler is basically a no-op.
>>>=20
>>> But for LocalInv this is a problem. On a flushed completion, the
>>> MR is destroyed. If the completion occurs again, of course, all
>>> kinds of badness happens because we're DMA-unmapping twice,
>>> touching memory that has already been freed, and deleting from a
>>> list_head that is poisonous.
>>>=20
>>> The last straw is that wc_localinv_done calls the generic RPC layer
>>> to indicate that an RPC Reply is ready. The duplicate flush
>>> dereferences one or more NULL pointers.
>> So this looked to me like a Queue wrap. After sleeping on it, I
>> decided to try disabling xprtrdma's Send signal batching. Setting
>> ep_send_batch to zero causes every Send WR to be signaled, and
>> that makes the problem go away.
>> This is a little surprising. Every LocalInv chain is signaled. The
>> only possible accounting error might be that ep_send_count does
>> not count FastReg WRs, which are always unsignaled.
>=20
> Well, perhaps you're posting several WRs, and the connection is being
> dropped before you post them all. Therefore, you bail out with the
> last one you did post being unsignaled. You had better hope that last
> one is flushed, because if it completed successfully, you may have a
> missing interrupt.
>=20
> It's really tricky to get unsignaled right, when errors occur. It
> might still be the provider, but there are possibilities on both
> sides of the API.

My current theory is that the only duplicate completions occur when
WRs have been posted after a disconnect. This happens in the window
where the workload is still active and the connection has been lost,
but before the DISCONNECTED CM event.

My expectation was that such a WR would flush through and complete
once. What I'm seeing is that on occasion one or more WRs that
were posted in this window complete twice.

If I add some logic to block posting in that window, the duplicate
completion problem seems to go away. The test runs long enough
without a duplication completion that I hit other bugs.

I never see duplicate Receive or Send completions.

When a duplicate completion occurs with LocalInv, I typically see
duplicate completions for all WRs on the same chained post. That
might be the case for FastReg also, I haven't looked closely, but
the Send WR these are chained to never sees a duplicate completion
(could be my duplicate checking logic for Sends doesn't work?).

This is with a QLogic Corp. FastLinQ QL41212HLCU 25GbE Adapter and
Storm FW 8.42.2.0, Management FW 8.30.18.0 [MBI 8.30.29].


--
Chuck Lever



