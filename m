Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1353F146
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 22:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiFFU7Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 16:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbiFFU7I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 16:59:08 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7442369B51
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 13:48:10 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256K1sCd029161;
        Mon, 6 Jun 2022 20:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=N9oJmvbcHKP2+QjBMBe3RuAvNuIOReB2K7ybVyvPXB4=;
 b=MoD5NzAToBRr2+XPWPFaHDTY9yPTjxZh77n4lBBo3XNiegcotub31qS5E+grjwsfONyy
 UA8QDmX6OMhJBALmGwzuGjwOvZhrMT7RztoN0eIBmwutKB2IlVX12b7VU5w7a4JPIwT/
 QVMnNQ6C59TKn0lwvY0nc+PSjIHg56XsGmMvt4k2YUVF4u4IFJjJBEWPz1aTcbCpRyeX
 EWalidKGo1poup2HjMdilOc9K+PiARkyU3yY/RFbxOC8crJMg1mpolpVhPAGJo9sGHej
 tkFDgLgHEM5htV4N3l+4TfYgHafD72zeFSUZtUuuN/a8hAFWdpDga/b6p1bpzUMf5JYt UA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ghpkn9du7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 20:48:04 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id A1A74806B44;
        Mon,  6 Jun 2022 20:48:03 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 6 Jun 2022 08:48:03 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 6 Jun 2022 08:48:03 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 6 Jun 2022 08:48:03 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOJDPK5eVZfpJ+T8MpdwVDUhLciPPmeKvIUXoFAoBMK3qj71TVzLvp7gNGERWTUgnmM5i/O9gHXvpCbrU7dQ8I+xAvLg7J7gWS0xAfynO/MoipOrFZEPSio+84nNJ76ZPS4ffXf0ubME68m7u3ilgRcVP7vx7KJ1GBP2MQiIG0UG9yJKofNz4chtnwGQehlNs0sLkpqNEy7A2eDan8KJleVR3Rqg7KQGydhbzwy0N223uBKXRsq/y/shbe1oEDFsV9ziLSvN/62GF7AUxXeVOwIlviKU5KpMnQVN1NK7jKKkykmKFG20tRfhOr/ntaJN6bi4dhp39G0FB2GLotcr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9oJmvbcHKP2+QjBMBe3RuAvNuIOReB2K7ybVyvPXB4=;
 b=OxUMuwbVekrdWiFdKi2ZDYxA3V6OCjkO/XMy/CYRG3zMFkTH+DtwVGhkK8TyHsGtPqVCaVQnivPCSvLifz7/qccPX0LNjtIXeda0EqAS0xhUWtU1y/6matzZzEd8/BCUM3YhB9DdFaw3Muze6kfoG2ZJAk9nwWuGvgtu90rIoOU24g8JggcCl+QkPuk0iGeg1XYoa2iW9LcrYJsnExmuz/uN3n+jiSwTCpB4MTgTZmCCUIyQTlxhMcqf0xMS4SbKhC6AePqHpLVwOp/s5yd5W0RMDOSF6OyoskqK8kUOH+PckSkUno/pr5RIWF4NCFIDWlZdZWEMyQ69/5Ke6iFMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by DM4PR84MB1975.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.19; Mon, 6 Jun 2022 20:48:02 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455%3]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 20:48:02 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Zago, Frank" <frank.zago@hpe.com>,
        "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>
Subject: RE: [PATCH for-next v15 1/2] RDMA/rxe: Stop lookup of partially built
 objects
Thread-Topic: [PATCH for-next v15 1/2] RDMA/rxe: Stop lookup of partially
 built objects
Thread-Index: AQHYebCK814GERTELUiK/fiKvygUk61CnTqAgAA7jjA=
Date:   Mon, 6 Jun 2022 20:48:01 +0000
Message-ID: <MW4PR84MB23076C49BE03CCC2D3EDA864BCA29@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220606141804.4040-1-rpearsonhpe@gmail.com>
 <20220606141804.4040-2-rpearsonhpe@gmail.com>
 <20220606171021.GD1343366@nvidia.com>
In-Reply-To: <20220606171021.GD1343366@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b8ae94a-28e3-474f-5b95-08da47fdd910
x-ms-traffictypediagnostic: DM4PR84MB1975:EE_
x-microsoft-antispam-prvs: <DM4PR84MB19756ED54C11ABC7CBA14560BCA29@DM4PR84MB1975.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YkrPeJDeHAoM2Gu4pPgYUqdwXLBUv2InlTn5tIK3HcyMBz3Ld3MXUOt8NMm6GZ2cR9SemAfZ/qBC5NPwp48zWBc4k41EB4i3OSDmw6Nw2VjK5lIFzN9dQnRhLXhlbKsUS+OMTFDssJFtdMNIMVm7sro2qQ77CKvLHNXkhUfROk/tOcUf74Asq5wNy53d4LWO5nXR8VRABmw6C7ME5RB9PxBJC89sBuZGDHLC2aLTX1sxSYrVTkV+nCxT5KZdiXezvjFUsb8RyN6OBilAGcVdeGhT3DF1IdWc7bFJ1l3PXjzeiXTVkhAyTp4EGRzjrZgSOndArzWqtm+s9zgETRm3jVh5EjzBh3BtzY6JthOBKmedPJuGRbZY0tp6zwqTDB9MkiqhQAn52PNyN9AcfBRQQG9yaAILhfOnfquk2dufS7chWJ/YKJanlcLl79GTMlxy85EKU4YxjytLrtB444/vwXOL4wHlduodMWTu1dqrgOjuvf1QgjuZvqVvARIMP/x0+Lgsv10wFzJuPHEIIKpTaQTadXSGJdye99FnvGYqEWib7zHFJho8o8fdwmGovH78UlANnXNvTbw0r8l6MnqTeNFWnqLAeQQmGibm+h2puNgBMC4l8q3PEXez24TmQYgaYRexDPRtE8xlDlRDTHlSZKayvx0iNZQH6LB9n0itownda5Ma3Dc/kfLR5oi9Drt7Ts0PR/1ELqW9iU/FptMfxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(5660300002)(8676002)(4326008)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(82960400001)(7696005)(122000001)(6506007)(8936002)(86362001)(54906003)(9686003)(110136005)(26005)(33656002)(316002)(38070700005)(53546011)(186003)(83380400001)(55016003)(71200400001)(52536014)(508600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dLlhuTYsfV+7Zr0XpO5K9yXZv9xaq5OP+Ux1UH3nCBGR83eQutQXkV3gEG26?=
 =?us-ascii?Q?K6xSKPAlULjLJS98pjxzJZ84VeII21RXlwg53bYMXSMEYYird5yj8/QNBQwY?=
 =?us-ascii?Q?RT+8fMQ24nXHxIUOmDXZO+8gz+6Sl6Aym3FtWLi8t6iiyduOg7fXBjDIO5Zj?=
 =?us-ascii?Q?upF2fHmSa29dJsITbDIgpNn8Ba4IdSx1Chi0GqJ4QBwhefGVA20lGlUzLji6?=
 =?us-ascii?Q?CSS/ecRRU6TLKOGoeeiXGx6AqZGKIaqZZ7c1BJcX3wOBVLhW47066YybJ7oY?=
 =?us-ascii?Q?6TbStYB36H42812JmiCczhWDGgZJP+6naT64Ei3Bc+SrYbKWgGXHJk32/fXa?=
 =?us-ascii?Q?w5xAgCvlBu7HO64R0UM+ctcJRqBHqyqWi8V+HrY1FizhCg57HkLaLB0TmB+k?=
 =?us-ascii?Q?wPl3nwpOWhgz+qGJusHdsIOgf5nyyaClxY/WvbETqC0AFO3Q3l5aiaqGvl82?=
 =?us-ascii?Q?e6WB1eAC/pRcHkRQEomYONjZiR4l4W3GBzif7c1PX63qsFslE7AOd/HIeWkx?=
 =?us-ascii?Q?nlk0uAMOKVv0d6GTIcfKMcEpaSW961aeAJXtLJ2Ml5OZyeOHy8gT6B92tQrD?=
 =?us-ascii?Q?h3usV8LkWKtTU7Ki1Hd3wnoGkI6s2d9pmGGcRTzh/X8eoNSH/okBlMTAlvE5?=
 =?us-ascii?Q?dPMOLSUH7NTAz9bbGRIjAJTj+d+7JbSZimruHKPpET7+85KJvIvW156sv6y5?=
 =?us-ascii?Q?vnH0/V77Xfc11ozUZhcLhvZYKCfGfQN52YaImMWVefDAzqCor3wGequLXgKN?=
 =?us-ascii?Q?pmRsBzu/Xq5PYIFozJNNUjqPSInKim+YFwlQG8QgMsjd+CpBEvLxgKOhh3aw?=
 =?us-ascii?Q?Giuw+OQKjAKY1O765BMSFY5+Ny0Chgz9U+ZgMdVCA2SS5X8UcfNSDbMizRBw?=
 =?us-ascii?Q?+XmZm+N8eMT2JylKtlGnGEM23kTrKzJL5XEJleGHzwGkyIblh0y4p2XCTJFG?=
 =?us-ascii?Q?oN2dTuKyx4H8I/6YbFtp1jPpzmtYAN9c2SJJZIAK+WB2xWEnSUKDtuijTGfP?=
 =?us-ascii?Q?zazBAZ0EazRhXi6SEI4eCmDRoPWrzadJRgkNZzXKsjwZ+lUYaUveAwdlgMGN?=
 =?us-ascii?Q?OMgCVX4AvqRTgqzBuILu++ipO2HLT7MzCfmjjfjcrLpFZn31jTd9CishW7B+?=
 =?us-ascii?Q?AxrfnGWUrLQaetV5JK8F5ANoz691q4AHGFmfSVlZ0oaSwgDm2hL3dR4/z78p?=
 =?us-ascii?Q?bbgwHLT27hzNJu5YtKO4/5izYUiEZpkJe0GHlbpxz57Msf8yWMeA2DYAfIAB?=
 =?us-ascii?Q?BT54LTuuZPADCKMtfvdeLCp9AxM38xcmAEGHir1nD6LAkc+P6gkVI6ZDU0hC?=
 =?us-ascii?Q?y1SYBgI1QXf93kKn32ysYNW3ZMoeX100Gp6lwqyWK9WodMm+FN7yGG3fdGKK?=
 =?us-ascii?Q?LfJMWqrbTc6CViGts5EvQyyzoaBdBEx6GYyLXd3uOqF8tY7CIGyWyTpvYyQd?=
 =?us-ascii?Q?pNe6QAvwC/pc0ain4cKsoaVtnWOBX162Ehe3G06Dp6SMwr7ThxSNwVu5OOLo?=
 =?us-ascii?Q?KHLUAAEDukVStMkG3LjKbAcux0TDJfO3hGAHMucrS9caduRXN1G8BrQI5BsM?=
 =?us-ascii?Q?465764sQYBuJMXIGG8uCdIqC/097NZOSYKANsivLQ789/6pDH/GN2DlkwRNZ?=
 =?us-ascii?Q?t583ADjh+moCGIJ30Gf2gBq59+rq47CqmIDL9FITSBIqS0J63NH0mWt7n0jz?=
 =?us-ascii?Q?5BPSQ06GqmOpcg0jYAJX9mcI8ztgdiZI52f1h8eB0y9qdsQlM4sYWTkalolx?=
 =?us-ascii?Q?x3mtl4U0kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8ae94a-28e3-474f-5b95-08da47fdd910
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 20:48:01.9747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dg2wc/lkWNllt0s0iGOsf0krcx3sldRB/rnne81U5F1OsHjbtlhZ703o0cMdUD5z7aZ8ZB3Uigp9ZshjIkkhjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1975
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 0wjjR7IbwmBOVjy3vcsIGMuWplkjOWSo
X-Proofpoint-ORIG-GUID: 0wjjR7IbwmBOVjy3vcsIGMuWplkjOWSo
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_06,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060083
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I'm on windows for the week in Minnesota without access to my Linux system
It will be next weekend before I can get to this.

Bob

-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>=20
Sent: Monday, June 6, 2022 12:10 PM
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: zyjzyj2000@gmail.com; bvanassche@acm.org; linux-rdma@vger.kernel.org; Z=
ago, Frank <frank.zago@hpe.com>; Hack, Jenny (Ft. Collins) <jhack@hpe.com>
Subject: Re: [PATCH for-next v15 1/2] RDMA/rxe: Stop lookup of partially bu=
ilt objects

On Mon, Jun 06, 2022 at 09:18:03AM -0500, Bob Pearson wrote:
> @@ -164,9 +171,16 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct =
rxe_pool_elem *elem)
>  	elem->pool =3D pool;
>  	elem->obj =3D (u8 *)elem - pool->elem_offset;
>  	kref_init(&elem->ref_cnt);
> +	init_completion(&elem->complete);
> =20
> -	err =3D xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> -			      &pool->next, GFP_KERNEL);
> +	/* AH objects are unique in that the create_ah verb
> +	 * can be called in atomic context. If the create_ah
> +	 * call is not sleepable use GFP_ATOMIC.
> +	 */
> +	gfp_flags =3D sleepable ? GFP_KERNEL : GFP_ATOMIC;

I would add a 'if (sleepable) might_sleep()' here too
Sure.

> +	} else {
> +		unsigned long until =3D jiffies + timeout;
> +
> +		/* AH objects are unique in that the destroy_ah verb
> +		 * can be called in atomic context. This delay
> +		 * replaces the wait_for_completion call above
> +		 * when the destroy_ah call is not sleepable
> +		 */
> +		while (!completion_done(&elem->complete) &&
> +				time_before(jiffies, until))
> +			mdelay(1);

Is it even possible that a transient AH reference can exist?

One of the tasklets takes a reference on the AH when building a packet.
It mostly seems to not hold it for long so the answer is likely no but I'm =
not 100% sure.

> +/**
> + * rxe_wqe_is_fenced - check if next wqe is fenced
> + * @qp: the queue pair
> + * @wqe: the next wqe
> + *
> + * Returns: 1 if wqe needs to wait
> + *	    0 if wqe is ready to go
> + */
> +static int rxe_wqe_is_fenced(struct rxe_qp *qp, struct rxe_send_wqe=20
> +*wqe) {
> +	/* Local invalidate fence (LIF) see IBA 10.6.5.1
> +	 * Requires ALL previous operations on the send queue
> +	 * are complete. Make mandatory for the rxe driver.
> +	 */
> +	if (wqe->wr.opcode =3D=3D IB_WR_LOCAL_INV)
> +		return qp->req.wqe_index !=3D queue_get_consumer(qp->sq.queue,
> +						QUEUE_TYPE_FROM_CLIENT);
> +
> +	/* Fence see IBA 10.8.3.3
> +	 * Requires that all previous read and atomic operations
> +	 * are complete.
> +	 */
> +	return (wqe->wr.send_flags & IB_SEND_FENCE) &&
> +		atomic_read(&qp->req.rd_atomic) !=3D qp->attr.max_rd_atomic; }

Does this belong in this patch?

Nope. That fragment got lost and here it is.

Jason
