Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E534A72C623
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 15:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjFLNik (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 09:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjFLNij (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 09:38:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91376F1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 06:38:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CC0kbQ006095;
        Mon, 12 Jun 2023 13:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=he5F9yzOgeZ+rcB9TLJIjTGUqZAAIkBcbLvRqrL1KMM=;
 b=Za2yzE4lyjSGQvfn7B9OtOIKmrZu4IPT4vdNCsUs7JSLDlGaXnxeJDZoTrXYLBQHIeDx
 Pg6wm0z8nXShr6uHKJwT8bhTfCyFgEtQuchX9EL3yg6RWSnqd9XuXwJSipGmtNFV1dEO
 80Sw7XVfQZqg+fIXds3FedN4VvBKl7vjYIsQ4A3qeKAolntA5kXUVC/R99tu8fYO+IVv
 HRQcWBbqjHSfMTtu9fcgDeYetzqQSoQpuNDQAAZGguEh8cNbcnAbFqI8k8/eWWnMhih8
 vB+qZijFMapkGeaZ7IYOuo77JEvtmSADt0LuLXMRCxoZx3AcNTJPwC5dTQMnRadZhNxl 2w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hqujxcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 13:38:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CDAOlX008450;
        Mon, 12 Jun 2023 13:38:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm91j5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 13:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MevPS2DckP7w2Lvvf8NB1Wl4zIjrHwuqHaJUpJRIFPXl4n1wz2x1i+6kuNpJxC9PWx0GNZAbYu8qb6IJ5Q8iv+wNVdXlTYi5py7Qhb4Du709Q566bmgMoQKwyK70pSfqS+RMOD55Ckteet0kt5wM2nAAh+3XR6qkCrA9vNHwLA1jOGqUuZ+c1ed5LQzF7fwvMTXtUqY3Y8dd6mCRDfLJ+rz2rSPb9TcBD1NyOiStneS14mUvy1CLbm44n5t8G8oDRPCZeGrElqMCGgEs27RDMgQyBjfNB+L5cLLfztUROSSd0KHOmmwGFgWP0HL+Ra5TO6dyE8zzvTj1gUZTyyeZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=he5F9yzOgeZ+rcB9TLJIjTGUqZAAIkBcbLvRqrL1KMM=;
 b=INXoSXNz7RxkQ18Mb9HT7KJ7UVCOyQAY5ni9QYditFTK2tgYUdhAKnJaG8q8eQRWKlKWrzQNyUnp+nikxuFM8zxTBV9+0fbH1NuQYwA2DpGKoyK72LvFVmVlPFrVUWrHpjnbvCW4OPDPlJ0S05arbjR0yNywJy3kQfMCb/ucJcquqNf19xW+d0QUeHRbGJh1BD+vVphXUnJBiKy9D839w7gOxGQVon/2APBKupXtJOYbu2r6c7GidIM7I5uWIOQ/4YplkiyGxSakTt7FDHBEjLrCm2IFtkyJ1eYg/C5yCWQCmmASg89OTgfPLJoupytFhhkEcIuKwLxNy6+oUypb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=he5F9yzOgeZ+rcB9TLJIjTGUqZAAIkBcbLvRqrL1KMM=;
 b=Gm0lU1Y/IScmlgaPQ4bDCHI80xqQ9ILaV2D8yLIs4BrNufAGOPfNaf27im25arWALzR08zDSBUK05gTc637MDE3KKiFS6p+2lKWlvGKnnXn7uhmAHaO66dIwiseQ3TGeLkVhJ6OQVDZ2EO2wx0hY6d2rhQclqAbrUvnxnLP07z0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7731.namprd10.prod.outlook.com (2603:10b6:510:30c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 13:38:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 13:38:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>, Chuck Lever <cel@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/cma: Address sparse warnings
Thread-Topic: [PATCH] RDMA/cma: Address sparse warnings
Thread-Index: AQHZmkTaE246fsT+50iLhtYRyzyux6+F6rgAgABvzACAAFoiAIAAegEAgAAA/ACAAAIgAA==
Date:   Mon, 12 Jun 2023 13:38:31 +0000
Message-ID: <1558DC1C-0253-4F3F-A16E-F0C68EF62E28@oracle.com>
References: <168625482324.6564.3866640282297592339.stgit@oracle-102.nfsv4bat.org>
 <20230611180748.GI12152@unreal>
 <64058A51-B935-4027-B00B-E83428E25BFB@oracle.com>
 <20230612061032.GL12152@unreal>
 <3E4B9E99-4B2F-40B7-8B14-D0A18FC01B4D@oracle.com>
 <ZIceBDrARRE4sG5P@nvidia.com>
In-Reply-To: <ZIceBDrARRE4sG5P@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB7731:EE_
x-ms-office365-filtering-correlation-id: a18fd9ef-df70-405a-d98c-08db6b4a4fb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGTvzqKQzhlgDUDuwMoSgqwV/0LBmVszG0n6M0K5XM52aJoZAZQvZNx3nbFqnv+JF0ryMbv9aQIb/ho6xlnN2mjTeyfk4cON4kf6u2cKvgJxRqRioqDXYATtIEAiuTDk037w53cIiOkqlNEe8atYidDC1miPOg5NfCfbtFB9OlF7eJhCEfVbB9sL6uBdnY7T/7HHKmu4z/yv1OFsNDpbuJOzh0+ZFTUlkgQoBOYXvZGmUnQq2hkSQbtgmHkyS5z7jhZNC1dzuuwtTltj0++e829J041x+f1fnECv2F2PRp3QfHLXnu1TWSVHObn6J2eA8m+z2l0CjDLI/O8q4A1VsVOk4ZO49Nf/pnbV6KHuaR4wGB2kl/eJZcTXTNrcv9lw0A9AjDbKeWFVUW4WvxIXjuSOd33Eb54PhoE7BHOoTciVyCydvvrjSICJTHyEK1DRN8bC+L9cxrD+pohDDWQ4FoXUPmmSjFb/FldIJ8mNGuh70Xgb8TBD+h91ELptB1cHqZvKsTWJRxfEKmQgdJW6UVZ9QcwxjUnr7cPs19k1T2pUAPZ5b9XfSJvCJqWybBcsi/XSGRQjlnoB3aq6EEBBzG7Nqingkr5OWr1JsTNBjMnzzHGZkazK/VBfsLtFPAcs+b46moKs2VA8OhrRU0i+Gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(66899021)(54906003)(36756003)(2906002)(38070700005)(71200400001)(86362001)(91956017)(478600001)(33656002)(5660300002)(8676002)(8936002)(66476007)(6916009)(66946007)(76116006)(4326008)(66446008)(66556008)(64756008)(122000001)(38100700002)(316002)(41300700001)(83380400001)(2616005)(6512007)(6506007)(53546011)(26005)(186003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cyEgMuLW+WdA2GhHc0EXstumR+H2zyaNqimzLDoc6AFtZNNiqcFDEuDJuMgK?=
 =?us-ascii?Q?0ub2KHLHuD551r/zUY0BtmxkkkFTg0kiw/peHeMQ3ZtWAJ8Gi8E4wWKiSkWq?=
 =?us-ascii?Q?mLswV5uIisVOFIvCCrcZPA4VpbRuI/b7MOAlieicWgu9QpH2MN+9Mqp+opur?=
 =?us-ascii?Q?SJzD99NlzHAxQuMGOy4aSWIrBtr7TV+ziNGZJV9ioWtOpv4Tx98MPKfZik4O?=
 =?us-ascii?Q?Nekr8rn5BfrJeFg4CvoJX8yOl62mG1JF/KFy5TIWRoRA4H3ofEsokMwu65Bd?=
 =?us-ascii?Q?5g8bsMJ8AzS1gqpXN9BmFtugnFIeXXJVwy2ao78+ea0Pwe03zJu1OZt1KZEU?=
 =?us-ascii?Q?TIn9dlgGTea9nDM22oehqfTyElC8xn1fnatbOPgQJRPkwIgT/RYJUdJsjdVY?=
 =?us-ascii?Q?3w9GPvBFFn98xsaFNJZ2p0YNoc0ehCNDITBHkTczp+0aoIHQjO/TEvqydz91?=
 =?us-ascii?Q?518auGOFRqm1FXnj3pdnF+h1qNdLlfwCsiWLe+d/8yjptru/5ktJxdenuYZB?=
 =?us-ascii?Q?MaRgoKJHChrVUyxNvgYH1pZeUkxmgg3YylPEzYYVvfj24z+qaqkm2egOXKVA?=
 =?us-ascii?Q?iBIfEhmxWkVRXmBq4uiU5vFE2BnVSGRnG4cMe95WxNLOw12wNE8eaUOJm99N?=
 =?us-ascii?Q?4Hlt9FdHCglc8gLv1BIIBhsxaEH+hZ8GB0nN7/sQuuEdgl7BQoMVSNJgL3NW?=
 =?us-ascii?Q?B5Zb/Wz8amXE8N+oHR7SyatZ2CPLwaZrvdCib8P8zw8wPk0lMJyoRf/HJp/e?=
 =?us-ascii?Q?NwciuMc+LCdvYD5UNSszsXx9v6wfiA7kz1jgvqXJEM+V8tGKyZKjWdmGZoMi?=
 =?us-ascii?Q?YTYCsMciWgGFC+shR9BqYWkmCdlPKvTBNIleaLExbNzRylEqYfLcWWKq+oDs?=
 =?us-ascii?Q?w1rnmh5YLyRbMTmt3Br9wxn6QDciC25yBEbKXV5zVY370T53rYG+FKAKl2qh?=
 =?us-ascii?Q?WBCSrPx97c5NrnpWq3uJL5s9gMG18DfsxA7pSWXXjlCk2zNlS+2135DF7zB6?=
 =?us-ascii?Q?Ml57Qg6682J9r9CcvdzHTltKP2ctxqikIXt1l6QJCxx3tp9cCV173QIIH4D8?=
 =?us-ascii?Q?Y4dqIX/SnmP0FkGzrVi1ckMoQ8dTUz0BuV9JG7EeHumJUm97ELo67AvwY4uP?=
 =?us-ascii?Q?JumjDqTI6WdDoiIUHCKwBGcn/DYOPPcKqjgN1E4Ylajf/ZvDkmPbi5BjoAjJ?=
 =?us-ascii?Q?spDLDG1c5/WZ6yWSipufrlWAOI+HuVzPu8fEl2Tssni9G7fuQvEY8w7wnF+L?=
 =?us-ascii?Q?CaAAFo7gcabEDntqc3XDctOf1v+ychx/i23Vi6DJ9b5DR+eZU62M58HeitNJ?=
 =?us-ascii?Q?T+NcvC3chv+rIOdAvcnRvFP4NvHMu8mDZIXtON4xOeEzSBfQC5f1mqlmSYm6?=
 =?us-ascii?Q?dtY7qyqNPnm+dzP7uFwoQmDFX87x7gJXsU0WpjJxoOMWmRA1BcxmLXEIdAW8?=
 =?us-ascii?Q?Xgatfomeq/rrzsFal5+cirUyqcKPQmnzQWgXK0pv3ogZ31cwrWcN+cSJgm68?=
 =?us-ascii?Q?YuBDEGSQmrKPF7gfM+hBcKZ67cHcTFpITuRswbfg75yevCTYIfhZ8AthgXDW?=
 =?us-ascii?Q?YCojFkvcA8ce46BWlzp1LVyuHnaN0j29H0KNBsOCf5/L3P3+qQYq9jsRh6+C?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8AE93FEC2BF49E4EAAF6CBE29B2ED808@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u59xgkv+raLmbNtrpgw4MOfmNwXW28qfzx+oGQ/wEhtUxp9LUSv53YcSjAcBhB8GmqTPUglwHTGbWRGtPgY/bxSZjq/8L0/VbPczzYaidiMvSaOxxKZPzAWlQJghgcZHUyaPf/ySHGndMJvEv8ICBjo8T9faTJtyuG5bRRwH8cWcKmt94tGaQPZ4DGHUPwk2eidzWgnov5rImjCft2vi7lgFNeJsTNc90NsrYlpj/qq/zGgSjaW3HEzGSMZ7+AJoL/xo/OUj4grEFGm8LEA0Kfs5D8Dr5hLWm1I9F5gMh352kKHH8jpc5BhrB9IDV41WpxYW6uHCpnTRWQz4RKJ7UZkrt0kpm7FyKf1pch9UOy656heokcLkVPmVac24uLl20nolUGo+iz2VWGXu2hN27Eq7tyrefoQhhnHa87wWhcXjneNqRSS8SSwTvDu5fhN4vBaogiypBY5IaXkZVEOuv+/M8JDPIYRghGRtWsHezFzIeu9zBQtnTaG0W6ul8cWE7gUrrdMQ85u5cZq59UBib4fE+TqS6K9u05dNbz8mqckYm9GqzQpkf2QGW51A30YJNKZ1krLI1yBm+Zx6ZFLQu9/irjI6O7jb47xtetnAke4geSPbDNPx3NeTwmSV9OGINg381iWRKnRQtbpjgnlLGwNejWYB6funBNrExcOe3dNUEGQFlEWfFTCzFeRSEWRWWSVOFKlWAgj2GYk+ynm7EazJkXuYabY/gbgLO+N0osDnCxfb2bZgzObS8ZOLDKqpPC8V8r16wgPXCTgR5yrAmTtJABsGs7PN9V5EVRRdOLuDuaZ+EsUraGOzQ4saPzLH
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18fd9ef-df70-405a-d98c-08db6b4a4fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 13:38:31.2228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XliNhxvECPPCQQCbVux2Zzcc0g+orc9reRXqh+2u+u59OstrCHbKUUUG6B0Knaq9Zh9wH5eSSFzin6SmhaiI+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120117
X-Proofpoint-ORIG-GUID: MhHyPqW6ipel9zJ4z84EmQJx-e1L44YA
X-Proofpoint-GUID: MhHyPqW6ipel9zJ4z84EmQJx-e1L44YA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jun 12, 2023, at 9:30 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Mon, Jun 12, 2023 at 01:27:23PM +0000, Chuck Lever III wrote:
>=20
>>> I think this change will solve it.
>>>=20
>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cm=
a.c
>>> index 93a1c48d0c32..435ac3c93c1f 100644
>>> --- a/drivers/infiniband/core/cma.c
>>> +++ b/drivers/infiniband/core/cma.c
>>> @@ -2043,7 +2043,7 @@ static void _destroy_id(struct rdma_id_private *i=
d_priv,
>>> * handlers can start running concurrently.
>>> */
>>> static void destroy_id_handler_unlock(struct rdma_id_private *id_priv)
>>> - __releases(&idprv->handler_mutex)
>>> + __releases(&id_prv->handler_mutex)
>>=20
>> The argument of __releases() is still mis-spelled: s/id_prv/id_priv/
>>=20
>> I can't say I like this solution. It adds clutter but doesn't improve
>> the documentation of the lock ordering.
>>=20
>> Instead, I'd pull the mutex_unlock() out of destroy_id_handler_unlock(),
>> and then make each of the call sites do the unlock. For instance:
>>=20
>> void rdma_destroy_id(struct rdma_cm_id *id)
>> {
>>        struct rdma_id_private *id_priv =3D
>>                container_of(id, struct rdma_id_private, id);
>> +       enum rdma_cm_state state;
>>=20
>>        mutex_lock(&id_priv->handler_mutex);
>> -       destroy_id_handler_unlock(id_priv);
>> +       state =3D destroy_id_handler(id_priv);
>> +       mutex_unlock(&id_priv->handler_mutex);
>> +       _destroy_id(id_priv, state);
>> }
>> EXPORT_SYMBOL(rdma_destroy_id);
>>=20
>> That way, no annotation is necessary, and both a human being and
>> sparse can easily agree that the locking is correct.
>=20
> I don't like it, there are a lot of call sites and this is tricky
> stuff.

It is tricky, that's why I think it's better if the code were
more obvious.


> I've just been ignoring sparse locking annotations, they don't really
> work IMHO.

Thing is that sparse has other useful warnings that are harder
to see clearly if there's a lot of noise.

No big deal. I will drop it.


--
Chuck Lever


