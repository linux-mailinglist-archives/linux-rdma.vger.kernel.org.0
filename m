Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF70D52335F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 May 2022 14:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbiEKMuh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 May 2022 08:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbiEKMug (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 May 2022 08:50:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842785EBF4;
        Wed, 11 May 2022 05:50:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B9hku6023549;
        Wed, 11 May 2022 12:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3IbGn1hDgk3YzxTMVYL+Xc6DmtnqqAjmGsSSrffkxn0=;
 b=PWZ6X/T6jaMZxseQw5h1u5jUyqU1LVa0sT+vf0y1yWOE5pGWGVTDgPZI4YrwYzLvjWg8
 zvzTywdKeYNVU5uVzFp3jRjDv7xoaf5+mDqdieL7PzJnWdJwMYr+0GjPMhmhzaPL1he6
 xDAsNSUUU8oIiyE/fMqcyDPgbW+93BsaOt45KUN3o+AfbFuWDg/xqPZGJu2V5RmSPyd+
 60jv/WWD8SeXoSKZCgcJUQSAEDo9QRUOWeUEbFanbDP0UMqSFoi/zDBim2KOkgqnunNn
 lUypSwtZH0bmr1yyuiifW45nRG9EPtYJ2qTMIftxOTPgJ2UT7himrRCds9uNL4zSjOpZ rQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcssr97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 12:50:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BCfXiE030114;
        Wed, 11 May 2022 12:50:27 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf73jsat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 12:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZR+NN/hClv7q7N1Uulhy2HC1wY8ggUWRoyAWm0UMm/wECMtUCi7b0ZSYxi/DxuImOrS3z7SK7jmef9dsPwYuD2jq+IbpJagTjkImi4M6WG01eWrbhTinqC366E1AyZBSnFXtFYLPEH90M8z9Bs8BNpCKOBCvZconeIlrLCNi4awRZl/KtVxISuLl3w7mG1LAlCGoWBbLGthWSWcBkUkizquL0CoGOYAz9dvd3SUKYYEDNd1voJ5wYHdc82ZhD+bqgK7vLQoQN0YYgrQ6sSYoHm38p3AhlPZfYETl1aEzkfjguerm9VASqm0f8kUEXVbPkI4EUVlkopxPzHkW9D/5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IbGn1hDgk3YzxTMVYL+Xc6DmtnqqAjmGsSSrffkxn0=;
 b=fcB1tvTK/z4By8/0kkOQVXbh+8cacwl5bgF/tIkf2Vkc+G+KI9w3x11xmwJUUlF+VzzYAiNAg7lHu9BrGpklZJkVUgBHl/aJlMmnOIyBwwl3ehzaheDg1Q4C7cc4kwK/J5L4conlDISxZ0L6KSWdwDVRhscb2Ho5eolKyR5Yl7QuMVxUqZJr7J7OlFa6xz0CZXxRrAGZd6Ho/gkx6OpiJmhkg15egT7ANaWyRQ55fWOw9niSTXnmUe6knGDTtvD6+ImbGBcEHV9yILgfL0O4Tdg54FTSW7nFyZ7JppWt+p761DgIHvTjNGPiYnq4+9JV02x4cyMOnHvtZt+a9TbWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IbGn1hDgk3YzxTMVYL+Xc6DmtnqqAjmGsSSrffkxn0=;
 b=kNprfy9XN6vfrbhW9+/K5mU3VgIKgLM7dPaHch2uzNGMQkoaFsUvMcCIP7DCw8H//EAoOv6y4sJwiHOC+HwIWgZts8pn6vrf9yv07by7VdwaiSOV/jEOFkESH6MltpS58S/yMhbIzbp1Jas64Dq+CU+gZmU4xs63UQhEOGRDNq8=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 12:50:25 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::b5ad:fa56:954:8395]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::b5ad:fa56:954:8395%7]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:50:25 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     Cheng Xu <chengyou@linux.alibaba.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] RDMA/rxe: Generate error completion for error
 requester state
Thread-Topic: [PATCH v2 2/2] RDMA/rxe: Generate error completion for error
 requester state
Thread-Index: AQHYZN4jBQJwtTYvNUiAcVHRFz66Hq0ZCP+AgABRjoCAAEcSgA==
Date:   Wed, 11 May 2022 12:50:25 +0000
Message-ID: <5160F240-B5ED-406D-B552-C74678A8FB1B@oracle.com>
References: <20220511023030.229212-1-lizhijian@fujitsu.com>
 <20220511023030.229212-3-lizhijian@fujitsu.com>
 <b37c53a7-86df-0283-1a77-c31af108d39f@linux.alibaba.com>
 <0eb4cdcb-4d9b-18a6-a030-59bb2b359c2e@fujitsu.com>
In-Reply-To: <0eb4cdcb-4d9b-18a6-a030-59bb2b359c2e@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b04bee2-8480-4b76-d03f-08da334cd1b8
x-ms-traffictypediagnostic: BLAPR10MB5315:EE_
x-microsoft-antispam-prvs: <BLAPR10MB53156ACB9A64350109E40BE1FDC89@BLAPR10MB5315.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N/BUYnp1oCRHvWVfky8iJ3CNk0cobr2F2TJ3Sz54RwvvHQkGaDMSH8qiIV4qwOqFfM4RPcMLEMRdFFO6R3BjzZRPjIVbpmiBzHtnPaEbD4KF7igMYX7CJS646TqjxsbZIhLjgsIEFp/uN74r2pCvGqqDadJ4L+GP0++oWf5JFxm8J4of07tUflhfJrMR+TPOtOtr26yHgK4xLq8/8qiVkmLQ3l+CQ2DEBv/8f8baLAzkVVRXGXTi3e1Qoig0NjG59lr6BD2m2FjGAdwSyR756sdh2RAQHV3/C2A8dIwF0VZJ8A8HVmao55+c8T7G1Epg/2V+cBwk3MkC8UqxgwjlpkKm09X5HSX87L/RdZfaERiAg0aTx9s1+91SNH65DHVEXk1sxiPDUhnxQzvT9zBJtBg4nnfur/69DMq+3BiLsiB0ZKaF0YWW1zTa/nhQPLFun/gG5hnPt2Yp+IDhtYHmq7bVV1L+PeY8uU2KqrcmHRR4ndCY0QgQQOM+YaTQSCRWTy6qH4Gvx1tPfc7oEvHtwLF8kGSrvs34LuHt6jPZabsalBBKqpAPV7OdoGoGaB1z6a1Eab0HWzdoIrnPm+35lY1ufDkFA188VP9NDsUR/im48Bc3z/9XqWOiFSAopIJhs81SQvREuxi5++jLMFBDIY+MpMxdfl/92ydIAxlXaO44K7OT02S2CzlxsPZtT+R9O84j0P8KKyWDsFYAYwEfwO7Voq1YJtE84EU8Eu1z9/A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(86362001)(33656002)(6486002)(8936002)(53546011)(71200400001)(5660300002)(2906002)(44832011)(83380400001)(6512007)(122000001)(38100700002)(2616005)(38070700005)(66574015)(186003)(54906003)(66476007)(66946007)(316002)(66556008)(76116006)(91956017)(66446008)(6916009)(64756008)(36756003)(8676002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE5Qa2dHeWpTWThMV2RNNC9JaEdJRXp3MGZDWEpwdnJ5UzBlTHY1R05nY25L?=
 =?utf-8?B?RUdPb2g3U2dWSEg3OTl4N0FQa3prYU5NUWE1bS9iVVhLVGdpUUJrU1d2Y3h3?=
 =?utf-8?B?TUpSVHNteDZaWTRqWUxQZmF4LzJJNTFSY25USmlreXk5VWhzOUR4QmZnV0lL?=
 =?utf-8?B?SjNBeXphcHdQTlRGRm82dDhjekJkQ1E3Y1UwUE5IckhPbDNPL2doOWNsV1M0?=
 =?utf-8?B?SlBCMlhyYUxjcE55M2R2TGhlcGdsQ0tQejFSUWxFWTUzNVdRR0E1TmJlcjd6?=
 =?utf-8?B?N3BDUFcyVmxmVFRXYnpPRXIrdHBLSVpXbElUMHd6aWNwY0g4TXBFd1pRTkRM?=
 =?utf-8?B?WERYaFpFZ1RMTVJ6dkdySW1VN0lmR2IwdVM1MGZScmF3TllDMkRMZVJBcjdm?=
 =?utf-8?B?bzlQOGxMYlo2UTdSeXVaa3dzSnpWYXpsYU9URlcrcXlCa3R0MG9OUGpHaUV4?=
 =?utf-8?B?MFU2VmJxN0gxeUlXN1BkTTVaVFNZLzRGa3JTZ2l5MUJEY0NGNGJpWkVGNlM2?=
 =?utf-8?B?dHVva21pRUx4OVFsWHNPL2lpcld2UFNaTTVGN0Q4RVNBV1l0bnBCNFdWUmt3?=
 =?utf-8?B?cWtSK1puVEZTdmpwbmxVZHhaZFl4V3BEMmpza1lTS1lSUzc4MW12cjlCYkpI?=
 =?utf-8?B?eFR0Z25xSnF6YUlxaUhqMkZPaW9XWDRKTmx4Q01mTnUrb3ZicENHS0RzQmNz?=
 =?utf-8?B?bkZaNGp6ME9vQ2hyczk3VXZERi9ZZEN3WWp2VndhVjZCd2c3LzhiTlg4aEEr?=
 =?utf-8?B?YmtMNHFCa0hEY0pNSkljcUFpRFZ3a09KMHVLaDBOTGNDbGc1VHczbUF6dFZ6?=
 =?utf-8?B?TmVUNjh3d0piT0lzQk9tbGZYbmQyaFRNb1p6MytMMnJrUE5TRDVwZDN2NG05?=
 =?utf-8?B?aER1bGpocjFZOVhxWXpMNCt2TnM5UmtHYzRNclg3SGUya09ldjQvNUQ4eTFN?=
 =?utf-8?B?dXJWTVF6SDFrUUFDY01IQ2VxUHFnRUcxVWQyM0YrK0dsZlZWTVcveDNWTGwx?=
 =?utf-8?B?SnExVU1yV0ZRcjZzMzlYcmxUNFpMOExKTndsKzc3cTVtbDU3UGhjY1BqWDVn?=
 =?utf-8?B?cHMxVloxd01aNDZWeWdmYTVNeTlsZFVvZGxNOEVKK3p3NkE2aWRzeHFSeWFx?=
 =?utf-8?B?VmsvamdlZUQ5UTBLYnNIQUhwTmRKS0pyTnk3UjMvTVVQU1JDenZnMWdrSkpD?=
 =?utf-8?B?cDBwTEpYbnBIRmg1cDVLZXpiZFg2Z0hZU2ZtRG9tMDVjcklPNmttK2U0NjJF?=
 =?utf-8?B?Q3lHbUwrODNkK3Y4dUoxcDE4a2FMdkZZVndSbXNVMFdJa1dSUnI2YUNXUkU2?=
 =?utf-8?B?a2lmdC8zNU04cTZGd1ZobXBjVTVqUlIrMnRmWW16a2d0dEp6RnRndGppOG5U?=
 =?utf-8?B?RUJ6Q1lWM3VqeUhSd24xclZyY1pZWFU5dlRPeVFKK2lxa2NoU0xPK3l2Smgw?=
 =?utf-8?B?a3hJQVJiY1lnWXdvSHpacHRaakJxcElVNEd3d0NUQ3k0bXhmMXNHNTBTbG54?=
 =?utf-8?B?YWlsbTlhU25MWXpxR09DUW1SUUxKK3l3MEc3Y3VhUS9TZXp0SkRyYmRKTjJq?=
 =?utf-8?B?OTFYckUralh4NkgvTXJ5cEV6ZE0vZUtXZVhwRG1GUEYrYkpYcTVLM1ZGdm5j?=
 =?utf-8?B?Tk5idFp5bW1HaytzMFZoTU5XTnlXOVRONXJmQlNzcWxNaDZabXFmYmJQZHJs?=
 =?utf-8?B?SGNQMkhNQUhpcHBNTWx6dW0xSlJFUktvWnB2YkJwd041VW9xQ0NKRmhTV1Rm?=
 =?utf-8?B?ZTkzZmZnZGpZdVJMdGEyRnhhZ21YaDI3YnMzOXlqOVoxZVRxSUpmbEdJd05m?=
 =?utf-8?B?RGNBRmliSXcxQ2h0VVFacmRUTHgxV3lOcW15dUtXb0VIdXpFNHphb0pqTHkr?=
 =?utf-8?B?eWhyckRNcVpQRTVBN3JuTDdRTER0STFtVkNINjU4T0p0U1lWd0ZJL1NGY002?=
 =?utf-8?B?a3BmOERTTzkrSitxaEY5cEYyOXJLTGxYZGZJUWNRazVkNnhRR2dJb3gvWG5I?=
 =?utf-8?B?eHRLL0tGRzMzYXpURHlhc3I4N3d6YjZUNGpXT3VTN3dzZzNFdW9TYnlCd3E4?=
 =?utf-8?B?S0ovY2E2Y0d5RUJqcG4wTFA5ZURGMTBVTy92UndFS2xycm9YNkw5UFJIZlE0?=
 =?utf-8?B?bzM0QS81aGVlVHU3TExXT2NGVjFzeEg4Tml4ZWwzaEFhOTlXWmo2VU40MzZp?=
 =?utf-8?B?eExvd0F1azhKRHV4YTRkNlNNMkI4a0VLMUQyNE9oUTl0WE9zRGVtMWFjK0V5?=
 =?utf-8?B?TG1TSVhYQk82OXMzdHJRNmNOaEpsSFlMUUJLVTRtczdaSkVlNFEzbi9sa2Mw?=
 =?utf-8?B?R1ZydlVXVVJlREIrYTI3dlpXbElyZU1jT2dtT3lyMkNicHZGRFIwN3Nva0RZ?=
 =?utf-8?Q?V1ntxe24OKCIt3u2nuMQY8Igu513Utniz0CdCux9p8uE4?=
x-ms-exchange-antispam-messagedata-1: CiaRDPGYGHqWtE8LDlF5oMTW90+hgrvAf2Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <966592ABD7D5FC4193C9826D1E9B3322@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b04bee2-8480-4b76-d03f-08da334cd1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 12:50:25.4811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDiesTOTGNv//FS7Y3S5a8+D6CSLD4CXbhL14NIZ3d1RdozaDn/W0i2OEHddy/whJv89WSyeICaHfQ+P9IJdvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5315
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110059
X-Proofpoint-GUID: dNzipJttAOpzChfz3As05uQJPHLYcyNu
X-Proofpoint-ORIG-GUID: dNzipJttAOpzChfz3As05uQJPHLYcyNu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTEgTWF5IDIwMjIsIGF0IDEwOjM2LCBsaXpoaWppYW5AZnVqaXRzdS5jb20gd3Jv
dGU6DQo+IA0KPiANCj4gDQo+IE9uIDExLzA1LzIwMjIgMTE6NDQsIENoZW5nIFh1IHdyb3RlOg0K
Pj4gDQo+PiANCj4+IE9uIDUvMTEvMjIgMTA6MzAgQU0sIExpIFpoaWppYW4gd3JvdGU6DQo+Pj4g
U29mdFJvQ0UgYWx3YXlzIHJldHVybnMgc3VjY2VzcyB3aGVuIHVzZXIgc3BhY2UgaXMgcG9zdGlu
ZyBhIG5ldyB3cWUgd2hlcmUNCj4+PiBpdCB1c3VhbGx5IGp1c3QgZW5xdWV1ZXMgYSB3cWUuDQo+
Pj4gDQo+Pj4gT25jZSB0aGUgcmVxdWVzdGVyIHN0YXRlIGJlY29tZXMgUVBfU1RBVEVfRVJST1Is
IHdlIHNob3VsZCBnZW5lcmF0ZSBlcnJvcg0KPj4+IGNvbXBsZXRpb24gZm9yIGFsbCBzdWJzZXF1
ZW50IHdxZS4gU28gdGhlIHVzZXIgaXMgYWJsZSB0byBwb2xsIHRoZQ0KPj4+IGNvbXBsZXRpb24g
ZXZlbnQgdG8gY2hlY2sgaWYgdGhlIGZvcm1lciB3cWUgaXMgaGFuZGxlZCBjb3JyZWN0bHkuDQoN
ClRoaXMgaXMgbm90IGNvcnJlY3QuIFlvdSBzaGFsbCBiZSBhYmxlIHRvIHBvc3QgbmV3IHNlbmQg
d29yayByZXF1ZXN0cy4gVGhleSBzaGFsbCBiZSBjb21wbGV0ZWQgd2l0aCBGTFVTSEVEX0lOX0VS
Uk9SLiBBcyBwZXIgSUJUQSBDMTAtNDI6DQoNCldvcmsgUmVxdWVzdHMgc3Vic2VxdWVudCB0byB0
aGF0IHdoaWNoIGNhdXNlZCB0aGUgQ29tcGxldGlvbiBFcnJvciBsZWFkaW5nIHRvIHRoZSB0cmFu
c2l0aW9uIGludG8gdGhlIEVycm9yIHN0YXRlLCBpbmNsdWRpbmcgdGhvc2Ugc3VibWl0dGVkIGFm
dGVyIHRoZSB0cmFuc2l0aW9uLCBtdXN0IHJldHVybiB0aGUgRmx1c2ggRXJyb3IgY29tcGxldGlv
biBzdGF0dXMgdGhyb3VnaCB0aGUgQ29tcGxldGlvbiBRdWV1ZS4NCg0KDQpUaHhzLCBIw6Vrb24N
Cg0KPj4+IA0KPj4+IEhlcmUgd2UgY2hlY2sgUVBfU1RBVEVfRVJST1IgYWZ0ZXIgcmVxX25leHRf
d3FlKCkgc28gdGhhdCB0aGUgY29tcGxldGlvbg0KPj4+IGNhbiBhc3NvY2lhdGUgd2l0aCBpdHMg
d3FlLg0KPj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWpp
dHN1LmNvbT4NCj4+PiAtLS0NCj4+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jl
cS5jIHwgMTAgKysrKysrKysrLQ0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZV9yZXEuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5j
DQo+Pj4gaW5kZXggOGJkZDBiNmI1NzhmLi5lZDZhNDg2YzQzNDMgMTAwNjQ0DQo+Pj4gLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4+PiArKysgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KPj4+IEBAIC02MjQsNyArNjI0LDcgQEAgaW50IHJ4
ZV9yZXF1ZXN0ZXIodm9pZCAqYXJnKQ0KPj4+ICAgICAgIHJ4ZV9nZXQocXApOw0KPj4+ICAgICBu
ZXh0X3dxZToNCj4+PiAtICAgIGlmICh1bmxpa2VseSghcXAtPnZhbGlkIHx8IHFwLT5yZXEuc3Rh
dGUgPT0gUVBfU1RBVEVfRVJST1IpKQ0KPj4+ICsgICAgaWYgKHVubGlrZWx5KCFxcC0+dmFsaWQp
KQ0KPj4+ICAgICAgICAgICBnb3RvIGV4aXQ7DQo+Pj4gICAgICAgICBpZiAodW5saWtlbHkocXAt
PnJlcS5zdGF0ZSA9PSBRUF9TVEFURV9SRVNFVCkpIHsNCj4+PiBAQCAtNjQ2LDYgKzY0NiwxNCBA
QCBpbnQgcnhlX3JlcXVlc3Rlcih2b2lkICphcmcpDQo+Pj4gICAgICAgaWYgKHVubGlrZWx5KCF3
cWUpKQ0KPj4+ICAgICAgICAgICBnb3RvIGV4aXQ7DQo+Pj4gICArICAgIGlmIChxcC0+cmVxLnN0
YXRlID09IFFQX1NUQVRFX0VSUk9SKSB7DQo+Pj4gKyAgICAgICAgLyoNCj4+PiArICAgICAgICAg
KiBHZW5lcmF0ZSBhbiBlcnJvciBjb21wbGV0aW9uIHNvIHRoYXQgdXNlciBzcGFjZSBpcyBhYmxl
IHRvDQo+Pj4gKyAgICAgICAgICogcG9sbCB0aGlzIGNvbXBsZXRpb24uDQo+Pj4gKyAgICAgICAg
ICovDQo+Pj4gKyAgICAgICAgZ290byBlcnI7DQo+Pj4gKyAgICB9DQo+Pj4gKw0KPj4gDQo+PiBT
aG91bGQgdGhpcyBzdGlsbCB1c2UgdW5saWtlbHkoLi4uKSA/IEJlY2F1c2UgdGhlIG9yaWdpbmFs
IGp1ZGdlbWVudCBoYXMNCj4+IGEgdW5saWtlbHkgc3Vycm91bmRlZC4NCj4gDQo+IEdvb2QgY2F0
Y2guIGl0IHNvdW5kcyBnb29kIDopDQo+IA0KPiANCj4gVGhhbmtzDQo+IFpoaWppYW4NCj4gDQo+
IA0KPiANCj4+IA0KPj4gQ2hlbmcgWHUNCj4+IA0KPj4+ICAgICAgIGlmICh3cWUtPm1hc2sgJiBX
Ul9MT0NBTF9PUF9NQVNLKSB7DQo+Pj4gICAgICAgICAgIHJldCA9IHJ4ZV9kb19sb2NhbF9vcHMo
cXAsIHdxZSk7DQo+Pj4gICAgICAgICAgIGlmICh1bmxpa2VseShyZXQpKQ0KDQo=
