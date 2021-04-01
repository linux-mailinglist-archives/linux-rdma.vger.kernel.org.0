Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A05C351A0A
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 20:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhDAR5u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 13:57:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52566 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbhDARy2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Apr 2021 13:54:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131FtQ04090955;
        Thu, 1 Apr 2021 15:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=P2FMFea8CwTrqluRleaKWD/glkma6hm45gNU/tJF1PU=;
 b=zal8e0GXf0AmYFsbfySbEg1jX7RXa/Urp64OzcRLWUkV4tvhVlED1zHJJme1d/fP+y6Y
 6q+3KbyyxQSmEYjtTdbO2PmCyuF7utcxPnX16J+RqeIk56CTGiA/oQbHnyo+DRpdFJS4
 5z9Y8nzVNOS3Td33guRml7fs/+6tvCAfjNPMWmz1+TObSgCaOOQwq/0+dBSQguEpmgml
 FyVCwhzmL5XqJ1nomUHWIZK0Bijf9NdBX4LlxTUIwl4MQSBrURUBW5BU4yMi/I2MJwf6
 VP4PtVhROPVskWMexyvctcHNXH9foTfOvC/VuQo43Xg5dS20buWhDzMaC37OHvGQbLaq 8A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37n33dt9ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 15:56:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131FehpL006247;
        Thu, 1 Apr 2021 15:56:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 37n2paqkpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 15:56:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlOxibtecLPwiCcTTHF7bxYDBvRkga/lgtp+nsiUwCXfmwxyICo2gAoL+D35vZBQKeR8c0RMzq/JsqK7e7K2aiUWv2eycQMaMV8iQQahLSe6SMOwI41EVU7WjvdneTgOCIrRbqKbVmw7KY4x1UmuV1qyvkUMrQITt+hyu4aURwlbEIR7Ub4f/fzEe/1T6hoVeHLdaI5T4/8D98Jq/4cfcGYIemPFYdJabT2QPTtv6jw9j6dn6DIv3KN9iA7BQrGo2f9JNRBg0Y85g9ydNBwwmzxY3fWGNbS9zCQX/KlRT023LJvtUppaK0KLC51H2CGYDDf4hgUeP56f9BjkzPnWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2FMFea8CwTrqluRleaKWD/glkma6hm45gNU/tJF1PU=;
 b=VnDR2CF3NQy0hIxb5EZkZVbWwRS2m3sTCj8dInd6UU1+N2YQA3kM4Sf7QiTKvfRyI1hhra4huGOu1xqrjm7Yzfdxe2w4UbpKI4qMgGIsyAYYfF8sBYkC7VFpT/hWCuXDjWeQuCDhE+xsDLkOcl1DTqNrCPy79NjCoC7CFhy37LwRsRQC/dN9FWEAY5kQzr0Sl/dbjw7HF2n8/yWe5wenSLNYIIAca/L9DgJHzWzfmslgaZJbb7Rz36LzTTFTMuo6pzRxx5OGh3SpW54YOz4BLWSmU/kXjxGS8nEOxmzMDZOYTbQ8lblC4WXiXmlWNe0aAYndqF54CFTiMLdRTQ8dkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2FMFea8CwTrqluRleaKWD/glkma6hm45gNU/tJF1PU=;
 b=CrPROTlBeQYEPuCxXr4YbnBgIk9kXCcostP7az/LDDKJTao84I9K1tcZ0oK/g6hdc16nsvYMSnqi0VfSP/Sbcba4CdSlmZmYaI7U19bLLKqP/nwLuTRc65FIUfSbIKoZ6GUf1QuJ5pbbIq/nEoGLKpKHxt4Hs8hIdTtr8IbwJvI=
Received: from CY4PR10MB1448.namprd10.prod.outlook.com (2603:10b6:903:27::12)
 by CY4PR10MB1368.namprd10.prod.outlook.com (2603:10b6:903:22::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 15:56:38 +0000
Received: from CY4PR10MB1448.namprd10.prod.outlook.com
 ([fe80::69eb:33a1:2d07:8554]) by CY4PR10MB1448.namprd10.prod.outlook.com
 ([fe80::69eb:33a1:2d07:8554%5]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 15:56:37 +0000
From:   Praveen Kannoju <praveen.kannoju@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajesh Sivaramasubramaniom 
        <rajesh.sivaramasubramaniom@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Jeffery Yoder <jeffery.yoder@oracle.com>
Subject: RE: [PATCH v2] IB/mlx5: Reduce max order of memory allocated for xlt
 update
Thread-Topic: [PATCH v2] IB/mlx5: Reduce max order of memory allocated for xlt
 update
Thread-Index: AQHXGmWJp8i+xPdCxUaGXGoNHWnqKKqRyJQAgAA7xICAADsYgIAAV88AgAI9RwCACaQeAIABcEqQ
Date:   Thu, 1 Apr 2021 15:56:37 +0000
Message-ID: <CY4PR10MB1448C03F77B4DDF8833489058C7B9@CY4PR10MB1448.namprd10.prod.outlook.com>
References: <1615900141-14012-1-git-send-email-praveen.kannoju@oracle.com>
 <20210323160756.GE2710221@ziepe.ca>
 <80966C8E-341B-4F5D-9DCA-C7D82AB084D5@oracle.com>
 <20210323231321.GF2710221@ziepe.ca>
 <0DFF7518-8818-445B-94AC-8EB2096446BE@oracle.com>
 <20210325143928.GM2710221@ziepe.ca> <20210331175312.GA1531363@nvidia.com>
In-Reply-To: <20210331175312.GA1531363@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [103.203.175.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c098f3e-46a6-4b72-c28e-08d8f526bb7d
x-ms-traffictypediagnostic: CY4PR10MB1368:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB136878F0DF5D930D79A1C8B98C7B9@CY4PR10MB1368.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZUvtJp1JDqOaa01IgvpoW7ZvRJaDi+f5/zEtfFW/bzsj+W6/1If802gW9pSZt2p5ENc5xNOl0ecrMWpgl5MBGYOSGT7/vMX12PhjpVqPhqlbtuFzkZM6g30EM5SsDmeHvjjyUWU3/lzZEIRuNwWbX2dTe4gByvax71+9N/mxJznl8SRC2AZLubkyfz5N0QE+ZJ5MBFYwpI3IHvxXn7c/bm9FwQxDgL8ZHRNqas0y7Sjxm0xz/IkUJqWqPNb/Qnf3zAjdDkBWsg3xXDZNg2Cp9HgC4FSmBT9j42oHg8WYx2DlLtnamFsXlXyVjZeTf+/3SJOLb5vqivewVDqBQU7x08T20iY2hf3mccfAuYJ4GJnSA8eUS4YqZBMXNHnt+QCSzQEOInYtDNg5P1eQsq3rikTtzux17490Qz3wstrxxjRzQyYXzmq7ubqa0j0afBw8FXxd16PHh5mogTJHEgsinuT7Y0o6ObN+rWIgcHMu4jHdOutQ2zb4amsiBCvOeCJaQKB1QCW7gyGaYz6r9D+U4O4V6lUE+eH5YLCDnY8t7XSyxY8QUc8IXJCkZ6OgNntKycwH2VLfCayZe2wDQtJqe6CG2PuHYxWi0iBAgTwoqN9pZL1NS7wYFEcZqflfLeED2R8SflCBJnJooPVybfcAZPPKgIvHKLruseJE8kpbX8o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1448.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39860400002)(396003)(6506007)(83380400001)(53546011)(478600001)(4326008)(6636002)(7696005)(33656002)(186003)(44832011)(26005)(5660300002)(38100700001)(71200400001)(8936002)(15650500001)(2906002)(86362001)(54906003)(110136005)(9686003)(316002)(107886003)(55016002)(52536014)(66946007)(64756008)(76116006)(66556008)(66446008)(66476007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CjuFaHBFoDHJm0iNNdc2AyEjBW+n/vR5a5RMCzthwdLiR+yftdp7yJ19/Tz3?=
 =?us-ascii?Q?Tx2BTc6urLnGEqHdi6c6Z/0fQKU234PyAjqWgxtAaiApEZzeYg6Xk5ZngsH0?=
 =?us-ascii?Q?cRmcyeDeadRM2Gfq4DrM7Q2o9FnQ1sYANbC3Ka1mVDNIkw5QlVm6aEk5qT5e?=
 =?us-ascii?Q?1DIRDr/h1GTgZU1DKo2YG077LJcnkSUa+B8Yv7Zpie1k47OcJ27inSGj/gWa?=
 =?us-ascii?Q?xSv6nXKeA8hW5Y12oNTj9rQUKL6Uk4x/4NccYtjCpUibIHVaut1IXVx3Dqyl?=
 =?us-ascii?Q?MNGgQNVkEISQa2cZRboUaDqmQomieUYbDrx2FxUdX43++5AmyTWF/fHoLJcl?=
 =?us-ascii?Q?jzkEHmOSoXkwjHavJWkCdtkwoHh2pBacRlNvsGXVWYp3emBUUCNb28zpVBM8?=
 =?us-ascii?Q?TVSi969+ZolKragrrqDvxVF3bP0saZtHpronNxE7NHP9qVyvQw3hpBYYRfO4?=
 =?us-ascii?Q?DW2ytuQeQIR+MDkMS9wrimNtrdhntWobLyCuPe1HCNKCsUWbujPgKiHVUTen?=
 =?us-ascii?Q?s94qf8TdV4Z5Z1s8kODFloTFC10+2dkF5TInXiITs3vRcua9xZb1BY+AEVfk?=
 =?us-ascii?Q?JC7TTReK+o/fTXsqdWpw2fVM3Q9O+oQDdetg2wLplGWCxoGy4ZhvKzNTyuUj?=
 =?us-ascii?Q?EXP0SMXT66QM16IOdozgDH/YQ8m999cW5jr07sAuwK3OwJE/lvbqvCsRNHE/?=
 =?us-ascii?Q?Hi5Qk1EGI0N8HRpoz6b4dRR7WcRcIu9qFNdPtGi/rB5ZJ+CtOymNIqR7lBX5?=
 =?us-ascii?Q?k1AfnbmCqseIuILWWVfH1FxGCAaOKGTeBkeA8Nk/itrj0eOY3o3Zfut1I9aK?=
 =?us-ascii?Q?xZuXhDzxE5bNgT814LGeftceFXU99i9sLL947NZBkICXFb49k8nomD7tBZch?=
 =?us-ascii?Q?eRwfISrOQeWAhN3T3Wwh5X+xk0hQC8V7mpwCC5sZzg4y8rfMd4QC41e402Vt?=
 =?us-ascii?Q?VUSVJsC75hja3DXsRrXtBlsjaDVHyre5hXt3YiB8bZUWdp/DJekIkk+on4In?=
 =?us-ascii?Q?eFOWf57Kur80TuKSruzxcbUNo/cyHVaVhsRDBPjZVHvup8YAIu1dbYRSxLyW?=
 =?us-ascii?Q?SCBq7PW5qpBBEFwjj/mkJIwHuZNljBXdQhXcbWI/BqSutArczZIIivb6g5S8?=
 =?us-ascii?Q?YMEdJ0uHtbu4b9HIbbYKjjo5GUxSOv6JounAaFJGsVG6GX8og+GzcQ9L/COj?=
 =?us-ascii?Q?oUa/6JefO1iEqfNwRy3UZwnf+qEoJuVylNRcW5Hbx2LYdJW5/gEA7T934vR1?=
 =?us-ascii?Q?0badDrxrsRoOcK+c090T9XVrkr8KjtQ8kgsewXZfMVIO+sD/KVCLGv+nlDYg?=
 =?us-ascii?Q?/JYm/twMbty/LoOAULaGzLRy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1448.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c098f3e-46a6-4b72-c28e-08d8f526bb7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 15:56:37.4759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TtEucn7irk6sxLlGE5qE+dvgl5yQVKI8VP5WsNghyxryRiHEMzqSmS3kxsGLdx5pFwdhzOcl/S7U7dw2Fh1vCg7gv/Axd6p6DnP1mtR+tr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1368
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010105
X-Proofpoint-GUID: asGQy_dk67aNyNBDOp6qD0UDcy8oLQeK
X-Proofpoint-ORIG-GUID: asGQy_dk67aNyNBDOp6qD0UDcy8oLQeK
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010105
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,
We will go ahead with just adding the "__GFP_NORETRY " flag to reduce the t=
ime it takes to fail the higher order memory allocations in case higher ord=
er pages are not available.

Will send out the corresponding patch.

Thank you very much for your inputs.

-
Praveen Kumar Kannoju.


-----Original Message-----
From: Jason Gunthorpe [mailto:jgg@nvidia.com]=20
Sent: 31 March 2021 11:23 PM
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Praveen Kannoju <praveen.kannoju@oracle.com>; leon@kernel.org; dledford=
@redhat.com; linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org; Raje=
sh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>; Rama Nichan=
amatlu <rama.nichanamatlu@oracle.com>; Jeffery Yoder <jeffery.yoder@oracle.=
com>
Subject: Re: [PATCH v2] IB/mlx5: Reduce max order of memory allocated for x=
lt update

On Thu, Mar 25, 2021 at 11:39:28AM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 23, 2021 at 09:27:38PM -0700, Aruna Ramakrishna wrote:
>=20
> > > Do you have benchmarks that show the performance of the high order=20
> > > pages is not relavent? I'm a bit surprised to hear that
> > >=20
> >=20
> > I guess my point was more to the effect that an order-8 alloc will=20
> > fail more often than not, in this flow. For instance, when we were=20
> > debugging the latency spikes here, this was the typical buddyinfo=20
> > output on that system:
> >=20
> > Node 0, zone      DMA      0      1      1      2      3      0      1 =
     0      1      1      3=20
> > Node 0, zone    DMA32      7      7      7      6     10      2      6 =
     7      6      2    306=20
> > Node 0, zone   Normal   3390  51354  17574   6556   1586     26      2 =
     1      0      0      0=20
> > Node 1, zone   Normal  11519  23315  23306   9738     73      2      0 =
     1      0      0      0=20
> >=20
> > I think this level of fragmentation is pretty normal on long running=20
> > systems. Here, in the reg_mr flow, the first try (order-8) alloc=20
> > will probably fail 9 times out of 10 (esp. after the addition of=20
> > GFP_NORETRY flag), and then as fallback, the code tries to allocate=20
> > a lower order, and if that too fails, it allocates a page. I think=20
> > it makes sense to just avoid trying an order-8 alloc here.
>=20
> But a system like this won't get THPs either, so I'm not sure it is=20
> relevant. The function was designed as it is to consume a "THP" if it=20
> is available.

So can we do this with just the addition of __GFP_NORETRY ?

Jason
