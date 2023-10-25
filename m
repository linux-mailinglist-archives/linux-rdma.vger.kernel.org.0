Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBAF7D5EFB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 02:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbjJYAPw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 20:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344368AbjJYAPu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 20:15:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE50510CE;
        Tue, 24 Oct 2023 17:15:47 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OLUSWA031882;
        Wed, 25 Oct 2023 00:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9juLid58TKrm9xbR/B34aHrELIoFf02XDYj6/vi+Kpo=;
 b=m+UadnK3zVz3bXfg8GInT4jGKrCxNT7V1COIwacPH8Ro5a44y0TljM7h6xw0P1pisaca
 ugJn5uBSvfAVsQFo3LRt+gREUCjS5hjvxGFEvxhloEcB5SzSDVLV1Wm+w8ZhVLH9NlKg
 RgGnkgo90mxuq2xragLS4vUUo8ZuITphY3kQHFNTonu7iyAtQhRX+6c9DcAwltWXhsYZ
 mn0DAqaBJ1aPrJnJo59YmK98ye9slbxqTQC/VNxkqTp6YRnnSDzH/n82IHLIhmoGAQDE
 fM6+f/Lm+quIxzs9OQN5edGy0Pm5hZmEmgLGzNA8ckAm8whSxIxB88HBD23HFNnKy1D6 JA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6pcxn5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 00:15:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OLZr4t034524;
        Wed, 25 Oct 2023 00:15:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv535xjfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 00:15:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hc7OjgAl9W6RxA5OgtCrwqlDyYGka1gXawVWWtvbyJLTn8JecgYlcLD7o1Tj4mso6PxsWKjLpbZDUxV5KzVennSDz2vVy8YCg16UtU4tez34SX/0lZm7E+NvnwGgHtb3UEl17p6wLayAmx+pejysHnaeCIdZUP2eJcYt1cJsGS5SaCBNJbwyJ9lAKpJLtH2yGTvu8nj5/EBFAnwtkQtREW3wxMlAVNhOGFgdakxNO5ZAFJi23EJpbxJeEkKmamZhifOwtshAA3IOm0rW4Hc7NE1Rm5vB5dB+VdIQviaIy6yvxoGqhKQEN6c21udJiuyYwTmGUjTLDzdSn8cbO+83xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9juLid58TKrm9xbR/B34aHrELIoFf02XDYj6/vi+Kpo=;
 b=bVlpbr2ZW7mNzREygGMK1MsLbLBevUJw/5d3XSCRM/+AoI1yYcgxwqbfrqer1/F29R5tKGhLVCZqvv8nH3uNhY+K7uWwdznr3hmTuKORDb+PyPHNo+MXpjs4O+pTIukFFM2EYzzko48QHW7mqsjnzgDy0bqv5+MA22rX3HiZxYuWCAlLYy6kskS5e4ULzWn0gZjT2ch49Jfj97YK+ItSS3b9nROx9r3Fi3n61UIVhR7h/dEz+g5zJ2CJ434h5vO0vzaskb7kAmMDjdVezXcPtAV9NQFYUrzs+QajMSM8gGeh9wWV7Nk8gr3xmwmmC4ULP4rJdD40n/QC7VfIRjMVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9juLid58TKrm9xbR/B34aHrELIoFf02XDYj6/vi+Kpo=;
 b=Q7Ycek80wbl1HKpPUDohvTISY5LDECztvjCrfNC/boj0CUT6WQxEyf6p5PtCDO48ie/6xBQYiQbk7PhAKY3LI///7sa4BOwFKKQlmNjlzU8vDQcrOpJ+96uEMywyAocNcGbZhzlBzenyuECQBmvKPJcpFBFeSNq2Tye1sAueTS8=
Received: from SJ0PR10MB5485.namprd10.prod.outlook.com (2603:10b6:a03:3ab::8)
 by DS0PR10MB6994.namprd10.prod.outlook.com (2603:10b6:8:151::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 00:15:36 +0000
Received: from SJ0PR10MB5485.namprd10.prod.outlook.com
 ([fe80::efa6:adb:9b48:84c5]) by SJ0PR10MB5485.namprd10.prod.outlook.com
 ([fe80::efa6:adb:9b48:84c5%2]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 00:15:36 +0000
From:   Qing Huang <qing.huang@oracle.com>
To:     George Kennedy <george.kennedy@oracle.com>,
        "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "sd@queasysnail.net" <sd@queasysnail.net>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     George Kennedy <george.kennedy@oracle.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: RE: [PATCH v2] mlx5: fix init stage error handling to avoid double
 free of same QP and UAF
Thread-Topic: [PATCH v2] mlx5: fix init stage error handling to avoid double
 free of same QP and UAF
Thread-Index: AQHaBqRwgrXAEMa6sk2OFFhR85ev7bBZoajg
Date:   Wed, 25 Oct 2023 00:15:36 +0000
Message-ID: <SJ0PR10MB54855B65988473FE7642E8F6E9DEA@SJ0PR10MB5485.namprd10.prod.outlook.com>
References: <1698170518-4006-1-git-send-email-george.kennedy@oracle.com>
In-Reply-To: <1698170518-4006-1-git-send-email-george.kennedy@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB5485:EE_|DS0PR10MB6994:EE_
x-ms-office365-filtering-correlation-id: 82366ffa-5efa-4f69-510b-08dbd4ef82e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dF3QWRS2zwaIfbgFCW17KQlPMyQK/kluEszdk56poJrgyKEr0RThjdkpCQeXJgFzKpfzVAd2ahsVimxWrRBMJxyGk8kSnp8urZs0ymO3YOboSf88adoh0Mwg8SB8DlBkGH2rtrCeLh3lVwvxEc8535V9ToouBnJgkU/HmT7/jsyYZYKtfRiqQBFrMNx/gJJ0rygAg/MQ8UVlZVZVeNqKwc82o1ou9Xwb0hUpDFrpYBKhcSMxoSFZhMWU+VEl2AkFyvHzcv2umNHxlsstBhAR9f8ffdxubN9HMGZtRwMsve9MCNKXmEaQTKjqycLfQnJUCQz9/v/CmE+sg8T9NCj47No5R2rEBKRsAIE3KEvi9kWuMJKhKadAxqzAyCYc9mQk1tpfbSpV2y2QOLSQU1X+jtnbmL8hLWE4Obfr6r4Qo7DTxLVwTmZ1rc39PwPNo5S1UUb0V2/i5EplKx9wCvnD0EYGwon9XfUrL8G0vTMkxut0VjoEXtH5xh2Pxb6Ut+V9jzEojcSTfri4/zmltoqldoCUnNqolATWfy2Jsrucb9/1GYeaifsgAl43RrQI0h5R+gL/BNDPTPZiY5mbkQfRQTH3OfD1Bh9ouqLt7CfOVY63A++Uqxbw5L3h1PimmjSV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5485.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(38070700009)(55016003)(38100700002)(83380400001)(44832011)(41300700001)(86362001)(52536014)(5660300002)(9686003)(122000001)(26005)(2906002)(53546011)(7696005)(6506007)(107886003)(71200400001)(478600001)(33656002)(66556008)(66946007)(76116006)(64756008)(54906003)(66476007)(316002)(8676002)(66446008)(110136005)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZXm0tSX2kZvIaKwWr7/zhA32ihi1XzKlnZKaCZpERgzmcJxoymANx/Uk4KRz?=
 =?us-ascii?Q?b69sOhrOhjuUP8EB6oSwataTks1TEHFOKE7mcKA/1WIfMYeLiQSyK4xitu72?=
 =?us-ascii?Q?t1oHWF/Vxde3Jc+meC1PvHAroUFhYE4XxxYI4wE7eH2u/AqYhy4lyP7qAbWx?=
 =?us-ascii?Q?Z8bdEMuC2rUc/Y78pASWvUxsdnbKHHxUTGxqC2ZWZAkP/a8jocE8a9LhTzrM?=
 =?us-ascii?Q?0snJa7/wM1jrJ8AuSniXFO6/qwk4FTIC6mh8nETclqpHTdbnfsvcvOjzUQQn?=
 =?us-ascii?Q?cdcczr+98+Bi7/fCPsEGK5egpM2AD+UYUx6l/5PYzSaiX9U29O0kSLkhzTfY?=
 =?us-ascii?Q?Zs0ezEipi4mZrI94mApqFYi2EX1JnKAW+OhmmCM78iKG1egi+R7teYhu782P?=
 =?us-ascii?Q?MUazlA8k8Iod4KpvB9sQzVn5YqQk1fy+dAKZpW+GUgoGR7adHAcVHuSuU4fN?=
 =?us-ascii?Q?ldhyZQYHjL6ycT2IytkDdp+RLslsl2QrsP1qskBo/JbgHla1YvJm6BTsAEJ6?=
 =?us-ascii?Q?MJxyVS5Pv4xV83yk5gzSWZpaLYBn040lv5Ahe4pRy/NwKBT6ErNXorQ7EpBp?=
 =?us-ascii?Q?xl6y0pLzJ+SStlv2J9A31qjLA3mf9YGg+K4if/b/DWAqdxy/JLaB2auv3oxG?=
 =?us-ascii?Q?bj18v9RmNSb9aJrSp+4sYaNZDw5/Bz1wI5ChX49+sSUKoIGDAZVl6HKhWcrT?=
 =?us-ascii?Q?8RDiUlHPetj/OeAMqx7pRka0SODAisEzH1sWmuK4lW2n2ESw2XM4wQpFnch1?=
 =?us-ascii?Q?3w792YJCoRQqY30XCm8BpNztmkuSRRPL3nfQc5hjyhHq97hb2CrCT2Wp+LmV?=
 =?us-ascii?Q?UbppzkmpevHT/YLoAJSYkI0KVmm1SvyCaN25Yq6MniL4TT0o75YPyAY88GYb?=
 =?us-ascii?Q?rFB8JGNlWRY55zipNRTa1QgVoNp1dKe7fOk3seb+xKQlaGDp1kxcXUJjauUL?=
 =?us-ascii?Q?TG524MrQHnoNikXEptnHc+LGGf312oem74X8GRtCase2YIRTbBvqe+Pw7Qo1?=
 =?us-ascii?Q?xcKA5Spy1J7VQfeZPUBjxZaatleXpmWSLLYKVedQvLsD+K4aE5KMZyY6M9Kt?=
 =?us-ascii?Q?412cN5HKwQd7OSJSbzD9wYTNKoO5lXOrtdi78r1k4phIwxNi9k0z/+/nA4lG?=
 =?us-ascii?Q?BHZGRxzR09NfCZJvvYLseEhmOqDJPNL6F9XgXm/0QaX5oHzETIzAs//dfnIr?=
 =?us-ascii?Q?ii3zLMVYDwdwYKCA85tfNJ2UOnmpWv3RKz3swT34viG9mfCt5hSmQuJiWAsf?=
 =?us-ascii?Q?TmbGsqFnA/Nh/hM56kSkp2xAFoNofj9omq9l5oNIX/rjIobkKx1kiQ38GgqC?=
 =?us-ascii?Q?HzYFPVrKV8Vsq5mTFGRLL3JDo8g7VuuJTZzIxrpqEopJU3Bk/2y0M6ilN9RI?=
 =?us-ascii?Q?VneUWLxNg1iG9GHrLHpWO+NQUGC4N6Hvw2nppSGsljf4aokGLJ6keCbx5dJl?=
 =?us-ascii?Q?kISLDw1bqsmk6lC1w2u9xYqGEzvlov08dfjNMovPo8yNU39NZOr098tHS/QS?=
 =?us-ascii?Q?7APHStvWxfZCTf6u25J8wKsw9RDKIh42puqjSvFnsEDUnVMXH7nmZ8hpILTU?=
 =?us-ascii?Q?VfcUhinZi0M+4IbjHCj0GE66LLsM+lH0L1G2cj97?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +uIEdm3Fpns/LyO1adY1Ei6cha027xMtkYOfsuI+Ih9fVvMFhFJvCLqWu+efSXOMhAUKy2lNSY0zP9MzXmLI/2kfAvmtroBBmj72MFT+9NaelTalOWQMT+B7C0qHitwj4EUQ5QIQ0wIU6iN4fD3ZdegrZIQfZrm56N+erwffXDZ1XqP0gdNSKtul+zQbFP4Y5k+7G67IremSUZ+g9ATktTWlMdOr24KMQPB2pivQrQwpchnNhynqNBaLb2OPLeQpXLT4OXTOiPZM6J6gr/Wa3Ge/wqnofdtasJOQhxY4Xpe/qGQj9ngoE+ikIVY+Fy8IPx/ZZeX8P9jvEs/2dcxtpifr8vqHRtH9TW1/F2cFqYpr1FcTthrs3e2wCEEO27NVwzxQnNeqTExDyC7drGuBz1PMlDNy1veGbp/K3ODBk8UO5ttOV1AtRLjHzYp9nwOzKC663kKPo5AdQZ3Z3fr6uv/amijPVk4bWgmcqqgIvo1hgSDDf6n3e2rSG9Bp1zOxIo5DgDP10FkM7C5VdQxmylHj8N2hLxxTKX4GsEAhpFJOp0M8zwgWBXJSNs56Xfjii9cBmhmyEGeKX+Ai7gmbMF68fOD6pqjPmwlMhjUNILQqlZv/vCRHtOnp+yQErgI6c1/HKexAmXGe3eurmxhY5SeiVAN6nhZOnjubK50y4HIDJCG+rzTjC3esYRKCUmGTzH4XWCDK85QiYPwyl30L8yiqZyV9S5CqllLtGhjA10bqB6dc7kVkGOdMFCX6ARD566KigadYfbxgPEKlALJlf9m0Yg0nCAQSfkz3Cq/er6mg9FgInR9XsamKBGaTPm9Wi8lC2Go8+TlMKmx9TPkBjfOU9hyAiJZ/ZGZv3gFWz/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5485.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82366ffa-5efa-4f69-510b-08dbd4ef82e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 00:15:36.1144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UT4E3Up0c2s01PHcNGbcHQYd4+Tecp7+F6LyzqbvqLnh5GfF/BmzpUx4AsUdb9idDvYSD/fFBj/1Y1BO4Nf/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_23,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250000
X-Proofpoint-GUID: KXSwC64YSCPJWEvkyxLLOtlsc2a4jSMw
X-Proofpoint-ORIG-GUID: KXSwC64YSCPJWEvkyxLLOtlsc2a4jSMw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> -----Original Message-----
> From: George Kennedy <george.kennedy@oracle.com>
> Sent: Tuesday, October 24, 2023 11:02 AM
> To: leon@kernel.org; jgg@ziepe.ca; sd@queasysnail.net; linux-
> rdma@vger.kernel.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.or=
g
> Cc: George Kennedy <george.kennedy@oracle.com>; Tom Hromatka
> <tom.hromatka@oracle.com>; Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com>
> Subject: [PATCH v2] mlx5: fix init stage error handling to avoid double f=
ree of
> same QP and UAF
>=20
> In the unlikely event that workqueue allocation fails and returns NULL in
> mlx5_mkey_cache_init(), delete the call to
> mlx5r_umr_resource_cleanup() (which frees the QP) in
> mlx5_ib_stage_post_ib_reg_umr_init().  This will avoid attempted double f=
ree of
> the same QP when __mlx5_ib_add() does its cleanup.
>=20


Hi George,

There seems no cleanup function defined for this stage:

        STAGE_CREATE(MLX5_IB_STAGE_POST_IB_REG_UMR,
                     mlx5_ib_stage_post_ib_reg_umr_init,
                     NULL),

Do you know where __mlx5_ib_add() does the double free call after the alloc=
ation failure?

Regards,
Qing

> Syzkaller reported a UAF in ib_destroy_qp_user
>=20
> workqueue: Failed to create a rescuer kthread for wq "mkey_cache": -EINTR
> infiniband mlx5_0: mlx5_mkey_cache_init:981:(pid 1642):
> failed to create work queue
> infiniband mlx5_0: mlx5_ib_stage_post_ib_reg_umr_init:4075:(pid 1642):
> mr cache init failed -12
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in ib_destroy_qp_user
> (drivers/infiniband/core/verbs.c:2073)
> Read of size 8 at addr ffff88810da310a8 by task repro_upstream/1642
>=20
> Call Trace:
> <TASK>
> kasan_report (mm/kasan/report.c:590)
> ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2073)
> mlx5r_umr_resource_cleanup (drivers/infiniband/hw/mlx5/umr.c:198)
> __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4178)
> mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
> ...
> </TASK>
>=20
> Allocated by task 1642:
> __kmalloc (./include/linux/kasan.h:198 mm/slab_common.c:1026
> mm/slab_common.c:1039)
> create_qp (./include/linux/slab.h:603 ./include/linux/slab.h:720
> ./include/rdma/ib_verbs.h:2795 drivers/infiniband/core/verbs.c:1209)
> ib_create_qp_kernel (drivers/infiniband/core/verbs.c:1347)
> mlx5r_umr_resource_init (drivers/infiniband/hw/mlx5/umr.c:164)
> mlx5_ib_stage_post_ib_reg_umr_init (drivers/infiniband/hw/mlx5/main.c:407=
0)
> __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4168)
> mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
> ...
>=20
> Freed by task 1642:
> __kmem_cache_free (mm/slub.c:1826 mm/slub.c:3809 mm/slub.c:3822)
> ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2112)
> mlx5r_umr_resource_cleanup (drivers/infiniband/hw/mlx5/umr.c:198)
> mlx5_ib_stage_post_ib_reg_umr_init (drivers/infiniband/hw/mlx5/main.c:407=
6
> drivers/infiniband/hw/mlx5/main.c:4065)
> __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4168)
> mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
> ...
>=20
> The buggy address belongs to the object at ffff88810da31000 which belongs=
 to
> the cache kmalloc-2k of size 2048 The buggy address is located 168 bytes =
inside
> of freed 2048-byte region [ffff88810da31000, ffff88810da31800)
>=20
> The buggy address belongs to the physical page:
> page:000000003b5e469d refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x10da30
> head:000000003b5e469d order:3 entire_mapcount:0 nr_pages_mapped:0
> pincount:0
> flags: 0x17ffffc0000840(slab|head|node=3D0|zone=3D2|lastcpupid=3D0x1fffff=
)
> page_type: 0xffffffff()
> raw: 0017ffffc0000840 ffff888100042f00 ffffea0004180800
> dead000000000002
> raw: 0000000000000000 0000000000080008 00000001ffffffff
> 0000000000000000 page dumped because: kasan: bad access detected
>=20
> Memory state around the buggy address:
> ffff88810da30f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88810da31000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff88810da31080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> 			      ^
> ffff88810da31100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88810da31180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Disabling lock debugging due to kernel taint
>=20
> Fixes: 04876c12c19e ("RDMA/mlx5: Move init and cleanup of UMR to umr.c")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
> v2: went with fix suggested by: Leon Romanovsky <leon@kernel.org>
>=20
>  drivers/infiniband/hw/mlx5/main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mlx5/main.c
> b/drivers/infiniband/hw/mlx5/main.c
> index 555629b7..5d963ab 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -4071,10 +4071,8 @@ static int
> mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
>  		return ret;
>=20
>  	ret =3D mlx5_mkey_cache_init(dev);
> -	if (ret) {
> +	if (ret)
>  		mlx5_ib_warn(dev, "mr cache init failed %d\n", ret);
> -		mlx5r_umr_resource_cleanup(dev);
> -	}
>  	return ret;
>  }
>=20
> --
> 1.8.3.1

