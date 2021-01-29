Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB9130854B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jan 2021 06:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhA2FnE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Jan 2021 00:43:04 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:51620 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229463AbhA2FnC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Jan 2021 00:43:02 -0500
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10T5fFbk013348;
        Fri, 29 Jan 2021 05:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=dvBe3GsCUle84Zf0+NkkIMr7eTgKXWYCeKhEoRUgO7U=;
 b=GZes8mf/9xQaovHjeSxgUZXbPmZFEQ2qENU+qnyeQxlNX7W7CY8W0bXlI4T7nlYsza41
 MAwlLDF5AVs1Abdene7RgSd5Dx/fS7c9VhSGHqeBOVkuiMbCdW97EnXm/fADhjciGHxY
 aVXwhiqcgSCTno++BSSXpvxquAyjlC1bASO+75PQ5pLDHlQ7S0KCCNfQtTUmVT2ls5We
 HsztplaGylj5e9B654NnRBkwYoiKPw83BNnoKA2RMK3q9c/jVeXFZoJ3UrIQzTV0GD9g
 AFeZ1uDm4X0SzDNIn1TaFo95IY4hH4w0PQKBuqOSNHRxdMHf5u+O3QzTTXzaTMmpFk27 AA== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 36ccedr08r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 05:42:14 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 5722766;
        Fri, 29 Jan 2021 05:42:13 +0000 (UTC)
Received: from G4W9334.americas.hpqcorp.net (16.208.32.120) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 29 Jan 2021 05:41:33 +0000
Received: from G2W6311.americas.hpqcorp.net (16.197.64.53) by
 G4W9334.americas.hpqcorp.net (16.208.32.120) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 29 Jan 2021 05:41:32 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 29 Jan 2021 05:41:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhfEeiKW5jSPnOPzwVMdAmlEkp/6Z/Fa5+dzxoj8kBVsaOswAgQSLyxngunIOGhc6z9DTxnj8HA13pR0qCuIB1KpCqABw1EZmuMG/IZEmrOZKMmU1er0O+stBwWbWYIkDceQdf3jnCJniYAp4a4HqMT7iedyOScWAjbhKiucFRZqIJ8mXrYfwX/N8u1Ns9ACb4C8/BD6a1vowM/YpxplofzS6NRBTgBfbI7ypwpIsevLfZNNGfOk7Nz7uw5SOBQZ0fUCXAHlCs+i4155wVMgxMgK4BXpE2xsvstRmZ3zpdWXuKiNK5ki8P1tMCNlw34ACGITQiEB69h+/FMlM45IOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvBe3GsCUle84Zf0+NkkIMr7eTgKXWYCeKhEoRUgO7U=;
 b=MIFReXKltJY4b+zwR3tW/FC4LugGKnow0DHIDwVvoGwYaN67kmDIo3yFodjDevtI23pNME9+MvrRceIYd/JvCNhizV2neUwzfDyuewmugrd0YRzLT10gcLjN9y5e/G4W0xcN0UyFZv1s/shukI62dCaRSeClM8Y/zAjmiGNZj3uRtnF16Azsj2Sys2JtUmGUgY1TAt5ZPFgHG/YmYc1dkP/niD+U6I1RNqEScLH74q1qDmZk3HuW3kExCPqBjkIZiB4JnZd+owpgae3e5ruLPQTxumrKgJb6mTWlDgtUhaGcSbAyoNrsWYWNup7pnpRkVrcUD948+LbIcjnw+xKibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::21) by CS1PR8401MB1304.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7507::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Fri, 29 Jan
 2021 05:41:31 +0000
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8]) by CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8%5]) with mapi id 15.20.3784.019; Fri, 29 Jan 2021
 05:41:31 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>
Subject: RE: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related WR
 with imm_data finished on SQ
Thread-Topic: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related WR
 with imm_data finished on SQ
Thread-Index: AQHW9ImNyfzWU0ybtUqjnD0r5FqHFqo7YAuAgAE0z4CAAGt3gIAA35OAgAA4OaA=
Date:   Fri, 29 Jan 2021 05:41:31 +0000
Message-ID: <CS1PR8401MB0821FFE3545ECF72861E25BDBCB99@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210127082431.2637863-1-yangx.jy@cn.fujitsu.com>
 <20210127120427.GJ1053290@unreal> <601259D7.1040207@cn.fujitsu.com>
 <20210128125421.GC5097@unreal> <60136F89.4070402@cn.fujitsu.com>
In-Reply-To: <60136F89.4070402@cn.fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cn.fujitsu.com; dkim=none (message not signed)
 header.d=none;cn.fujitsu.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:e8ce:e6e3:ff39:a619]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5332ecb2-c454-4ac1-b434-08d8c41887f9
x-ms-traffictypediagnostic: CS1PR8401MB1304:
x-microsoft-antispam-prvs: <CS1PR8401MB1304278B94E4C7F7F3354C0ABCB99@CS1PR8401MB1304.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XLs0sZJyKyVnuFFixWEQWyhYv2dvGQCsghu2lf3vQXQ2cXCPJRM0J+/IWLPdCPQp2aYKZhmrz7Jqeuf0sl0vnkt/KkhKYzRa29mw9QibTm1ipmi0K2YcrjS+Y2djsctwwMX5rwOZ5hITJYuEvx3qc9C/ZQdvyBM5uu3vDViA3efVoCeEGdmsD9F+kIAcQnwuiAplUucfLN+3Mo4HNM/1WxNqzFHVuVAZsQHY9VgxAnIt96puK2OsyTUjGW3OXUEQAJ0O6SbNx/TntdcP+ca0/S0X/2rIMNtGkNeWG9zbpSC2zQrHbenUTW/mZ00h868jPWVRk4r0p8gfCOxoNzEoeeGZ9SxC8hySPOAg55zUJDDZe/NSnaiQR9+hXZNsb7o1BR2JpwrJH4Mo23FQx0i982Fyw4ezpSz8t1u1glLIhLIsqM3+2ttlsMzcaYt7RZ3bXBNNGH0FBIlvq28xgTNQPcMdeXWxg3k7kZ68vLZ7u+LXXBRBg3D05kY4I08nRWOai6Fvo3uwVas2wp61zeKfFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(396003)(366004)(376002)(66476007)(478600001)(66556008)(64756008)(66446008)(316002)(83380400001)(66946007)(71200400001)(76116006)(110136005)(2906002)(54906003)(53546011)(6506007)(8936002)(86362001)(4326008)(186003)(7696005)(5660300002)(55016002)(8676002)(33656002)(52536014)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ih2saeJ7h6VEQLlNKbYOWGF9uBYKQh6J2lKTBV4MyuhC5WVJbecWVX1O6zBa?=
 =?us-ascii?Q?wAXvHoylVx3GJOKXTvGqnk+vNZvedf5+jMBR73uIJ2Lw3x4YV6Tlr1tAa2jr?=
 =?us-ascii?Q?bnesDtfORMKYBizFet5B+HIE4FueSysHOpYpEDyAavBpPeFsi63gg35cZOzd?=
 =?us-ascii?Q?8h87/Yld3oUT+ZLX9eqomu1iLGupdvvl9tJvtsqZZ8CKR2fGSRupISfsL4sc?=
 =?us-ascii?Q?uqSeA6YbCg0ZmGWi9VS+PJoqEhiA/yup2sAYMkGh4ZMM+u2zi8xDmv+x0mk/?=
 =?us-ascii?Q?qMdHKKh3/c3vdi1KFcxzvHd21bkHHTVFJ1eBlSKYxDmdE9HtLkEatmrAHn39?=
 =?us-ascii?Q?qkei3SKFgLFpkGZDsgqn+JuN74FWz7eQHGLBn1NmVUStm034K+FJliMXoDT9?=
 =?us-ascii?Q?cjsNPezhHQvuTG6czdrVSD8Rs6yOYsSVkv391+BQqJQnI4uM7lOl1hHfgQkQ?=
 =?us-ascii?Q?wr9uIuh14CyohM05XRXNTDTTKKRIHpfS5snMoIu4HnHYsEupaLIkXTVct5yS?=
 =?us-ascii?Q?td0EsJ18YvWJ7rqL9DCrOhqudEqIDR3X8V2dQbdU9dVC6mn+0IrV3hNQkn4i?=
 =?us-ascii?Q?gF7/5eiGwkRf5x05V2jDyJG/l+XPb9d2sF8F7FEwvNHFjOWwz4Oq6Jui3l/R?=
 =?us-ascii?Q?CdWqlSuXGlz44G9RH78WL0O/aipZLWf+M5siiZS44tx1DZiOGkHJXL5Am4j+?=
 =?us-ascii?Q?NyAwjZoPdRY63tE5i2XxgpAKSEbT7I5H5qCMz+42hrJXhiK8bpk8WDZDBVkb?=
 =?us-ascii?Q?U38ImWm8nYd1GVvANXjjPgIPDKndo96Ffh/n9/f+0d45rj/GeAoUVu4ask4Y?=
 =?us-ascii?Q?TG7hFILD+HP1NQP5UV4uzk+LQp3T+bt9LmXxBcbLk6rB3XfzlE3KzokkzA1D?=
 =?us-ascii?Q?okST+B6Bz0OQkA3kZw72Mbo/KuqZnEkAGRwyeez2L55c9ZSG57TC+K/a4Nv0?=
 =?us-ascii?Q?6AeM2rChRgsnJbgQtu+q+X8e9opJZprshaJ4ek/QMu/5t6egi4JRaGw81oWp?=
 =?us-ascii?Q?7PUiK6z1Xx0OqCfHVkkDpg9Z2r+c8iz6fpDpscP7lUnKdR40ywdDYA331X37?=
 =?us-ascii?Q?+fJ4c334W1ogZ870/swvmLbJ924cm9Omdu2oGPAQ1Xnf0herfaSAzXbTHJZf?=
 =?us-ascii?Q?WyV+TxyYYpYT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5332ecb2-c454-4ac1-b434-08d8c41887f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 05:41:31.1223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zz0ECaGHDHiTzDZOYFLEeQSQABgNmBbaGtO9Jph8yVAjMslbUFS01Hs4bNqBCjqBz5YiRsk90Ux0aPK2NI+DzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1304
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-29_02:2021-01-28,2021-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101290029
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



-----Original Message-----
From: Xiao Yang <yangx.jy@cn.fujitsu.com>=20
Sent: Thursday, January 28, 2021 8:15 PM
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org; jgg@nvidia.com
Subject: Re: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related W=
R with imm_data finished on SQ

On 2021/1/28 20:54, Leon Romanovsky wrote:
> On Thu, Jan 28, 2021 at 02:29:43PM +0800, Xiao Yang wrote:
>> On 2021/1/27 20:04, Leon Romanovsky wrote:
>>> On Wed, Jan 27, 2021 at 04:24:31PM +0800, Xiao Yang wrote:
>>>> Even if we enable sq_sig_all or IBV_SEND_SIGNALED, current rxe=20
>>>> module cannot set imm_data in WC when the related WR with imm_data=20
>>>> finished on SQ.
>>>>
>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>>> ---
>>>>
>>>> Current rxe module and other rdma modules(e.g. mlx5) only set=20
>>>> imm_data in WC when the related WR with imm_data finished on RQ.
>>>> I am not sure if it is a expected behavior.
>>> This is IBTA behavior.
>>>
>>> 5.2.11 IMMEDIATE DATA EXTENDED TRANSPORT HEADER (ImmDt) - 4 BYTES=20
>>> "Immediate Data (ImmDt) contains data that is placed in the receive
>>>    Completion Queue Element (CQE). The ImmDt is only allowed in SEND or
>>>    RDMA WRITE packets with Immediate Data."
>>>
>>> If I understand the spec, you shouldn't set imm_data in SQ.
>> Hi Leon,
>>
>> About the behavior, I have another question:
>> For send operation with imm_data, we can verify if the delivered=20
>> imm_data is correct by CQE on RQ.
>> For rdma write operation with imm_data, how to verify if the=20
>> delivered imm_data is correct? :-)
> Probably that I didn't understand the question, but the RDMA WRITE is=20
> marked with special opcode in the BTH that indicates imm_data.
Hi Leon,

The quesion is about how to get the imm_data in applications(programs in us=
er space)
1) If client program does send operation with imm_data, server program can =
get the delivered imm_data by calling ibv_poll_cq(&wc)
2) If client program does rdma write operation with imm_data, server progra=
m cannot get the delivered imm_data by calling ibv_poll_cq(&wc).
     In this case, how does server program get the delivered imm_data?

Best Regards,
Xiao Yang
> Thanks
>
>> Best Regards,
>> Xiao Yang
>>> Thanks
>>>
>>>
>>> .
>>>
>>
>>
>
> .
>

Write with immediate deposits the payload into an RDMA memory region and al=
so consumes a receive work request and generates a receive completion event=
. The immediate data part sort of looks like a send but without any data in=
 the receive buffer. The WR ID is copied into the completion event along wi=
th the immediate data so software can correlate the immediate with the work=
 request.

Bob Pearson
rpearson@hpe.com

