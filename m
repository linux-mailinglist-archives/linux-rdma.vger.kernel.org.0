Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA6658AA0E
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 13:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiHELWV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 07:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiHELWU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 07:22:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D2F20BD5;
        Fri,  5 Aug 2022 04:22:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275A5TN6006270;
        Fri, 5 Aug 2022 11:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1ctBnoGWPrgG54jNnl013X5UISDafseGHzr85rUimIE=;
 b=xKzLtfSNcaNEEV+/8c286Ubz4sR7pEii0MayA4aSESUBd5eTTq0ApMTulr8Mm2ufoRq3
 fnqTYVFqZz5SckP+z+TSHFUgyQKoMHHks8+ZCpQWoT5mRT1omFFbBnaRZao25rNBcE1F
 BBW3AUte3EMz/D7bA6aYvi5DBprzjeu/GHneM3/hgrQN7tF1tRSytfZXMiH9EyTroKFW
 CGzur21rGqRXoUgobugZpLIxps6R4hlxvAP0RauQMnFUOJdsGkj2eDtVZrcPoVYs+RWA
 gaboSAl3X31UwerGZ9Qi4w8mWTMHit0tFat5qox9eIRfshu3yoo0bWYpvFfcgEwvNqvt 4Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6tqh6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 11:21:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 275A04El003010;
        Fri, 5 Aug 2022 11:21:56 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu359wqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 11:21:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAyfN+biTujxSwPLY0/FEIgVqNmdjzQJyq/tF8Up0feHqiOvAW7DKL4QOwcNmvqlFv305TNpjVATUgTpITcGXXzwyTrHM3PkeZ4Aff7ZgmdGdxQSLBQp3M5AUVHRQDNFZOzXDjcx14vXUqnkoKYfpbdBzlJuOByPoeEiCDHTLPRdbbSC0MvgOnU1jSqyTWP00zJdsikjCYWlqLgmd87GcosmmafFFq9zg32bwyP8vYLVObrCaYhk+ONIjeH7Zau03MGmouC0qDYEDxJOiEAV1oX2vfnKzifsG9A20/8I1PMuSf2p23cBAnxIgS3a+WjqEePSUqfaF9iBKyvHYXM4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ctBnoGWPrgG54jNnl013X5UISDafseGHzr85rUimIE=;
 b=lM0TTvNAwO5kDvJeor4ERJK8W/o6y7zOjb6qvvzD3qwV150St4VlKIKNaENMBhujnkGQ7C24UR8tiM9ZbA7HZi2KQlil2aoFLhzGSmWIVYBmiNYi62pHL7ZwDI8Wn7Zbjms1tuhqK1L96LU7I6P3X1ThvzK98mFch+g6ka1sdkR8ii4HojK3pNRkTtMEVhk46AoF/FeWAZn+Ya9leIQIl8fJXSFZI3eZ95P3ylfkCnZ/5qxAve5uijKLVq5f7+0jBE8U1mm1S0huZCGCvMtQ4Lvm61YgVQ2rH42lMtFUgspE//+OuyEPmQuLpHi8TNbQSEFwu3/eqtTuS4MVsWXVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ctBnoGWPrgG54jNnl013X5UISDafseGHzr85rUimIE=;
 b=JKF/6V5Io9OWJqSF71Nh2umLE9siywDHM1TJ0NbW7sTKv+PDRL+ObucKhYInyjchzEWjET9b6h+bkV1F9/Ooi5EXD7ROuoaZIpwtnVcfO9gyCTwqx1srIstm+eousEoIVuo4Az3/H9ayeG1C+sCNzR3hu2vXC5X1IeaqKjeeLbY=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by BL0PR10MB2963.namprd10.prod.outlook.com (2603:10b6:208:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 11:21:54 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf%3]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 11:21:54 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Dongliang Mu <dzm91@hust.edu.cn>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rxe: fix xa_alloc_cycle() error return value check again
Thread-Topic: [PATCH] rxe: fix xa_alloc_cycle() error return value check again
Thread-Index: AQHYe8/FJJbPDZ0ej0ioquz7QorGFa1RxqqAgE68y4A=
Date:   Fri, 5 Aug 2022 11:21:53 +0000
Message-ID: <46D857DC-26BB-44F4-954C-A42416B474EB@oracle.com>
References: <20220609070656.1446121-1-dzm91@hust.edu.cn>
 <YqrwibTkaDig+QfI@unreal>
In-Reply-To: <YqrwibTkaDig+QfI@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3729.0.22.1.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee962c54-47af-48dc-d9a2-08da76d4b37a
x-ms-traffictypediagnostic: BL0PR10MB2963:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WC01XWprpS/tb3hOvww36Z8ci8mHIPS1Jzrbs6efF933JPaDjCpQePAzc7PNZ0oXlPa8I/TkXMZf9KVahRyKQftxx0Qh7d6dHx3WXE5nqcfKbvo6xAG+EuNnUlQAcuUBYSS1Sn/NTt2sWmjbbeo2iq4s6v7YtcZV/1WhFM7o6e/Cst7zAzwnweiyiElDfJFT13g2rNbY8ort0UbOS0vvbINfg7w/vMV4A2w8zxPRVI6N2SWL3HAstCUS4ussgJV1SvqyPD6XqynvmsxcEfcawwwlEgRxL9erS6GCOlpJUVD5yyzKUfqEnD+HufIJ70yfxxJaorz2M/We7mYeuLx3qOkMfGnS/PDI11tlJ4vo8w8SaoSrOAa3+Sb0QcdQ2JXsmlfztOHEM2wm42wHQCF/xRNlfbyAn0YM3W0awx90Drs2eHJIMiAqrh2F4tQngUJyCXAg6dCBWGA9xNnLH34QkhTiIeqlqsqBRyybsbhEx3XVZVbdiABkkEEclex3/0MiWDzQpvSZ6EteoYlFdmtybxMlRC9LG9kBTzHx/C3FvKFziPMK7490RnEa/GyPwSnJZgg7nYWub28BWn+2bu2V4iSFdZI0fJ/3Rg4HFnRdU5CQJPNaxMUCEYFpdgUZNiMqydsR3si5j/GggkksC1pryFaO/hpQpCCkHrB4CCh2D2ENENMO8FTZNFzlrYE/+GDF50rJWEmKa62nWqHkjPjOsJwxKTWNZHAAmZCQigWI0g7gPeAgJrqsTMNVjWneFT54zoG8KWCC1hkEI0JGoLzxF5SeOmyx3hDqzFHbbYg81esJMw8NPLKtoJvkNnPGtWGt8De1+yZ4hHnH5wHYhbx4PA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(39860400002)(376002)(346002)(478600001)(6486002)(41300700001)(6506007)(6512007)(5660300002)(44832011)(2906002)(6916009)(33656002)(36756003)(86362001)(54906003)(71200400001)(53546011)(316002)(38070700005)(2616005)(38100700002)(122000001)(186003)(66556008)(91956017)(8936002)(66946007)(76116006)(66446008)(66476007)(4326008)(64756008)(8676002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/TeH+isymPHqFq4LxKvkmKDzauEXih812jsP4WWIbcRlPfvWk1D9iVgrIxx6?=
 =?us-ascii?Q?q3HWUxE/jMoRWe89MvRJ9Jz2pEEo7bbWjL83BGxe3tcpB0XiS9z+cfOggSyi?=
 =?us-ascii?Q?WXSfIFkXp0voDI84MtnNI62c3BF7Zu1m4B8GUG2prsZB4rYbkcc887HSVLTQ?=
 =?us-ascii?Q?5IQ3crRyoA/ogMIm+EFW1byaBIgJpSpaIg3nzmtr9OhOdMaBekd8K7OsyIHC?=
 =?us-ascii?Q?2EWhk37xltyG9YvuIi0HrIuvmfcwlCn5FGNk4DLl9ZW+UH6wKn0yDXTxe5mA?=
 =?us-ascii?Q?n9l1rhbHL/y1SjgjjVsVFDJLVUBjHMoHri/BQjGK1zsMfLfKhAouPC14Wylr?=
 =?us-ascii?Q?0nppSDIMkpZeoExks3AfgAkIxh2g1tdIM+Z8suG/DHRCVeT9neHGIYmSkmMe?=
 =?us-ascii?Q?dnj4et5OJl8QZvwfNEvN+8cav2x8/Vlj+O6dNFFOlb7+xh/dbNSFQOA+7aCa?=
 =?us-ascii?Q?v0eA3zdrE8o/KnHykWdqRhN8NwobIj6BhTvkNrv9y3kPfSaIePEhGnl5OKcr?=
 =?us-ascii?Q?IcsPaX5u4/6RKSS3iQtXV2igQ+C0R+yAxSFQSrHN5eCp4GEpJtM4SLKIl1+s?=
 =?us-ascii?Q?K9AjDxQ1TFmkmvI5RKQyueJrK6Z0nBMBR3EmCNChojzOqmaJj78696qBWo+J?=
 =?us-ascii?Q?WCl5cSxejA4wMquwe/LdemBP617MWihrBy6Mw4cSMZrFfAObioAaylmDEgXh?=
 =?us-ascii?Q?yYcGf5Xce45EyS7m2fbYepjptmTiZU5GBbBF9WMwkm7atK23uc/eUahmD98W?=
 =?us-ascii?Q?DFx+P6LaVleTtS3aN+xoBdL5e0aI5c0585nSpsOE3c+kD0n04Dp6zRr8KcW9?=
 =?us-ascii?Q?NKCEmxBFpg9ih5qo9GlY52dIQwPJDdwewhBHuewBjE1ShOjN0jiMu1m9/xNp?=
 =?us-ascii?Q?uACd+xzucOmXOZrt8AqiYJEm4FFsQ+JOnPmM7rRtH/+OgJB8uR+PJ7FRKVVY?=
 =?us-ascii?Q?b3UU6D7tmqfAUlGv90+uknPdG9NjWxCpZTvPU54lz1N9n0hZYRhlkhycddiA?=
 =?us-ascii?Q?lXEigrJXwuOxrV2LTXrmYP1UZMw3bQIzbk6SYp3N+YovbI33yjEOlPXxLHyR?=
 =?us-ascii?Q?mrl5Vd2B6jNcbRkppBO0nfqDs6Wt3yDwITPNg23WOm1Fb8fYzJjQ+uxyq4GP?=
 =?us-ascii?Q?Bp8SkeTWyTP/cMjdom1ymDVMpJCphg4d4RCkUz37D0gXaBy+H0VktlxbYjv3?=
 =?us-ascii?Q?IPRx5fI5z8TTvVByy6mUFkyO3Npr1OZhVbB3HPomy0aKzXtLxZ8twE0fJtFC?=
 =?us-ascii?Q?bsp/7K7FuhjqvaUE4jMMygU2br3b76ve1Xn5DC5ZdmOISCkGnvuiGzzNTfvo?=
 =?us-ascii?Q?4rs34R63LbBfGIqeaXd/sy8VvIHIM7jA0bMwtCmTxsX4wy3RIaI2686PhgoE?=
 =?us-ascii?Q?1fnnYGN1nW/Lu6A/JPK+JdyQhJrIGDnZ6zmduih7MlsBrc4JL+TG8hh+O8+a?=
 =?us-ascii?Q?3JpYbxhaUSN9+j/q7gp3Mo1ro9k7SER8v/bSLEWyJmQwfkSgPhSy9GMojC+z?=
 =?us-ascii?Q?XIJTB3HUeVNNc8zwg0SqdgCq98BufyuHu1fEe+OAbfe5gyudkiVbOhAg22Wa?=
 =?us-ascii?Q?zVQZM9nmga1L83J6BP0bC5T8I2JsBMbEyJX6ABYV5nfddjHm5oRHLwiP9aea?=
 =?us-ascii?Q?RwwGs2lv85p8i5yH3MR7/L3ZiaDoK+ey90fc78cV5aSVx5stDaL/m02blXch?=
 =?us-ascii?Q?uU8mKA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <578D11755B6408438F784642104A8F12@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee962c54-47af-48dc-d9a2-08da76d4b37a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 11:21:54.2507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BW1LG3snM5kewZzegFMjCWpKX7Ex35cnpllMnLfe6E3aCzpZKKbPk6MJDckbVe2efYC19sY4zv0wtPcEPQt12F4IFgIihyElCl46lenb5No=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_04,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208050056
X-Proofpoint-GUID: DRgLtvMHp4lfMzid17EzMrxW0O2g_86k
X-Proofpoint-ORIG-GUID: DRgLtvMHp4lfMzid17EzMrxW0O2g_86k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I erroneously sent a duplicate of this patch last week because I didn't see=
 the fix in the 5.19 kernel as of yet.

Do we know when it might be pulled into Linus' tree?

Thanks,
    William Kucharski

> On Jun 16, 2022, at 2:57 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Thu, Jun 09, 2022 at 03:06:56PM +0800, Dongliang Mu wrote:
>> From: Dongliang Mu <mudongliangabcd@gmail.com>
>>=20
>> Currently rxe_alloc checks ret to indicate error, but 1 is also a valid
>> return and just indicates that the allocation succeeded with a wrap.
>>=20
>> Fix this by modifying the check to be < 0.
>>=20
>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>> ---
>> drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> I applied same fix to rxe_alloc() and added Fixes line.
>=20
> Thanks, applied.
>=20
>>=20
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/s=
w/rxe/rxe_pool.c
>> index 1cc8e847ccff..e9f3bbd8d605 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -167,7 +167,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct =
rxe_pool_elem *elem)
>>=20
>> err =3D xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>>      &pool->next, GFP_KERNEL);
>> - if (err)
>> + if (err < 0)
>> goto err_cnt;
>>=20
>> return 0;
>> --=20
>> 2.25.1
>>=20

