Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445D437BC65
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 14:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhELMYT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 08:24:19 -0400
Received: from mail-bn8nam08on2100.outbound.protection.outlook.com ([40.107.100.100]:1507
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231730AbhELMYT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 May 2021 08:24:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQ/AkX/XTxrvp9gxlg6O5Dq5R0174mfNbnT4YujKdNdAP4CW1tocEhrFYFjc7bNP4cx0o3TPVqjitk/VLCh1j4LbX2wH2Ddo8V+HYhnY2fooy5DA8O8VEYAi0WK/uWJeaLwUlNNsEO/Lzzoh24GRPbEziuhN1qXwSJ3pp6htA/jGJDrJ0hNirZuzl36h9Pa34M9dYIy1rRSj44mD8bI7J89GjC43QUuOfPQlYV/5okBS8ZYc8m+ANY7dCSgJJrycgsmG/ib2/UaD7yhCJiFPEMi95FgBJT0ScSfqaYKYjmP6WI8q0xAPn6/dA2qgSSgauluWOZOk5lN8CIGb5sHriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7ipd2pwu4YKebdTap/w37mJVdhkJFfamIbRKTA4Epc=;
 b=Nsjj6uouugatgudv3s3GMZz47i87K+BEk9J7ShMci9O7el6mMcTj4m4cTcXMSTgiNsCLcfUp9S5owSanIxDqYwQwz0fDmot/WlqWM+dGVaqSLlUqGQkR09lTB3UXAAwTeBjpDqVf28L1mqNYgznSFMlUgsGeqo/6Hv5LdZN435HwblFbFHpuBsYuyVtCLPkT+N0Ynvz/cJGOAxLUzulGynIgk81n52dlDu5ATcMBYPPOznDQocWuUdFF61Xo72O8NVEIxjZuB9bA9uBEB8Q3jTroQPovsb3YdigaUy8gZ3HeqbHz6ozZquXa9bTUIFPPWBOuLl6T4yvyZQwU3LrQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7ipd2pwu4YKebdTap/w37mJVdhkJFfamIbRKTA4Epc=;
 b=URQaLbBqkBf7chQ9mpj5i+r8R5t8KC1d5765E18KLwRGw5Z8xzRHGj3EX+ACAas0ceuVT9i3nkFaqGJQeueO8jyXY8RJ2CMmP8rtusxgAx8ITbuhn2ROjvvoZw7BKRNlxP2vMkrNcuRUcWxLAFbXYN3WiipZUrsiSmj5YZH3+ocDRImNEc10qmetWRf/Sq8lV28djM2WLwosuVHZhgeaLrZhKKp4ya8lkr67CQPIGBQeJn0pXGTI/nhjRghfAvtnfpkt/GycR8ZHeJwyQt9jlQiwWQU8duzVJXtvy6/ikUCplElS3lOhe2qImiTQh39PXx5yM8D1AzZhGlvxQwx2dA==
Received: from BYAPR01MB3816.prod.exchangelabs.com (2603:10b6:a02:88::20) by
 BYAPR01MB4072.prod.exchangelabs.com (2603:10b6:a03:5a::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Wed, 12 May 2021 12:23:06 +0000
Received: from BYAPR01MB3816.prod.exchangelabs.com
 ([fe80::d145:208f:691f:1ba4]) by BYAPR01MB3816.prod.exchangelabs.com
 ([fe80::d145:208f:691f:1ba4%6]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 12:23:06 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Topic: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Index: AQHXRlGKOHE6QFLZoEWMq90D8Um/darfxaGg
Date:   Wed, 12 May 2021 12:23:06 +0000
Message-ID: <BYAPR01MB38165194C3FE39850D61C6C6F2529@BYAPR01MB3816.prod.exchangelabs.com>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
In-Reply-To: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-originating-ip: [70.15.25.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d192de3c-f95d-4635-92e5-08d91540b281
x-ms-traffictypediagnostic: BYAPR01MB4072:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR01MB4072E4784E33D09EB3A7DE2CF2529@BYAPR01MB4072.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B/hMF32WPNit3fohxts5q8hoeAvIjQ8JMv8xiZDThrLvtzRSqGdBBRXz35Cl+WV5OZ2SFqigUglnc2p1dw1W4uOcpF3IFPOW9OewQ0Fy4AkKhmhm5GKvYA9An1BsepGsnKbI7kZ9IVL6I2tK9zczCgVjf822zwgIEFFLpWtRuv1Xcp96ANMFZVc2KF4uUV5BBuikbGAS5tJR9nnWUEMkzk/AD8uzZ9V8yYVwxwyI8hnpcGRwiMTwZqgQQy3Z+rEUnx8IVS3DqfGom4uPsMIMs6WxqqR8e6F1d/dqr0si5G6d28FfoLsIDbmtwH77Ceii2Jq+ed5NZUwWWwsO4FmVx2jgkQmaOoEs5fpLO4toXyqHmvyp8J1rWRdhyGJcoA8x/IrtiqadKjzcJJ9j+9gYrgBgHWtsCkvC0Sg1xYUBiAM6esigggQ5uYrMWWo7Z0Qvu4Kh0DRdxYSFedvEXXlMCwVXP0UJdLrIIQUAluaOh+bE1xKA0FDsTuqYF1c4AG/RFEQEh1jQarFLBLUOIc3GddEtfEQWeXQ0Es9YI9EUtlUGiBEsT0czBXf5dcNEOXJyxRrpfNTKYSDubBazuSgpEUOZOGiYmeHtL7ko74B87Rw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB3816.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(39830400003)(346002)(4744005)(5660300002)(86362001)(8936002)(316002)(110136005)(52536014)(55016002)(9686003)(186003)(478600001)(66556008)(7696005)(83380400001)(38100700002)(66476007)(26005)(122000001)(33656002)(8676002)(66446008)(71200400001)(6636002)(64756008)(76116006)(2906002)(6506007)(4326008)(66946007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ef7voK4iyX42v88V+fIV8xm+GHY1OqXev9HuYAkeMGLl2gG02SfDvN3DT8yd?=
 =?us-ascii?Q?lZid6FdfU+gfbZCR/Ai4b5qreZ7b4QJbIkLHPJRDa7BO5HC3TfHnMdwiHSL0?=
 =?us-ascii?Q?DTr9Tsgti+FGKQnYFVqUR5k2GXyLMx4y7hbSUf+qlqCsxyj8Ftlz6DsLhVP5?=
 =?us-ascii?Q?gvnCUpnvxblCgYqREbbFGYEsPLVQPmMcipkCkhZ5C8T5BhVYtcljnBxLRmFS?=
 =?us-ascii?Q?I9TGGPaKx7OCX5DFtJkSvuq6qHn88M7ru5vxlrk89VNdomYdgQ7cA9uy8/0o?=
 =?us-ascii?Q?0PxW2gWVEJQOR965bE9QVlBuzNeAQhxUsrNg1sg9EsABHk76u4z4CPNyinzJ?=
 =?us-ascii?Q?25tAXFr0/76bfbgYzrMGQpar5CVha+YCIg3Xdl6LbwqODsZ6Ivl9jbWOtbF8?=
 =?us-ascii?Q?fDrzdMHR7Z1ZYsp9GNba5hEq8QFBUC7eplv/mTAqhfplFwnGXuoThdgg1/Aq?=
 =?us-ascii?Q?3rKV1ZmRsH/GahlLExF0VBhNdrYV/ammSltrR1TDduihGbP0bt9TuXQhrxtz?=
 =?us-ascii?Q?XCeFZwH4d4oZ523uzyDcrBHjQzga/muKtksNZF/G8HYHCzTgMokOTlOBXfXx?=
 =?us-ascii?Q?6WY3A1vD3LPlmVV7eb6UqJW4+CTawT9FTKMnM1RvezMAf9A49yNEH7e9C67z?=
 =?us-ascii?Q?pWm3fT+qOuPjQXQzP/jCuifa/fiSNmmuwp2d1dlzhR7dPb4KLuJbldTycL4d?=
 =?us-ascii?Q?aWTn4JtD04sm011hi01tRUPXgMbmrZEuBFg01VttLUwAj+qZO/o/mTA7SFV0?=
 =?us-ascii?Q?6nmwUEj+b49y5fh7pOLcUTnwF2Q6nInVz5jFqzpbbzekoJ2K50kNvZxGGHq8?=
 =?us-ascii?Q?WXfjKnWWPXADCVznZnJAN5etncvzhQxhpwJ1yCrPI6oW0N9Fi80hm3w1n+Ja?=
 =?us-ascii?Q?iEKNxK5kL+HEo4ixZjvKkDBugJaOOSe1pYthj2xfXtoaNK+Njrwo3TNPGeZG?=
 =?us-ascii?Q?d7WmXCDUmQMgID4nPTXoQH9ZDcrn8/oThuzF+NN2QZxt5Ey32j6y3EFrSOmk?=
 =?us-ascii?Q?VRteL7KSKYeJJF3MY2WIIkEajEiZF5v/0jwCbpA769q2MJyqB8H8wGI383oB?=
 =?us-ascii?Q?BvZP+UKo+K9hD466kYnoVg3G7WHx8CxPEsTdlEsD4Qjs1bENPhglowSuu7dy?=
 =?us-ascii?Q?X093pZlqGRK9oyV2A18ySmq1Imx6771eeVTq4aV7j7bnADhIyk5MEEhko8/d?=
 =?us-ascii?Q?Gpy1YyB0dy+heffNwdn4msOBtBS6iZaoWTkxCi4dpqayrCa/FrjhdbtdOEGU?=
 =?us-ascii?Q?pVYMQkm8sFXFWHN8PCfQI4OqB5u59i2ZbvltGTCn20ZLJsiaJ0OwHJU9VBbu?=
 =?us-ascii?Q?l0A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3816.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d192de3c-f95d-4635-92e5-08d91540b281
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 12:23:06.3903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDOMa+oYVVsjUH8QnInqkfXGKrK6giJucsNmj/tHIyK3Y7DHFnG9Q/rrQmC8WDgQzV0c8hvyL1+vs2k/C3vkaFPRRyKaBMPXTRVw55h4YMPrwB0L7W0xA+HyFHXjtXZE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4072
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -	struct rvt_sge r_sg_list[] /* verified SGEs */
> +	struct rvt_sge *r_sg_list /* verified SGEs */
>  		____cacheline_aligned_in_smp;
>  };
>=20

Since since has been made an independent allocation, r_sg_list becomes a re=
ad-mostly pointer and should be moved up in rvt_qp to other 64 bit fields a=
round timeout_jiffies.

The cacheline can then be dropped for this field.

Mike
