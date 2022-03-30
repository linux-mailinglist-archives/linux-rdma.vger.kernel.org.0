Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631D14EBF8D
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Mar 2022 13:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243420AbiC3LIL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Mar 2022 07:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343490AbiC3LIK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Mar 2022 07:08:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52616E08B;
        Wed, 30 Mar 2022 04:06:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UAptla011575;
        Wed, 30 Mar 2022 11:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WKuY1jzpfVZmTqLNnBH/xp61YmnZGefhZ9J5OeWJ1P8=;
 b=vKd5ffcctbsDcLCbzDtAqnWowWSmX3LKI8mnPqTPTfg9w7cPMOzUOMVsRnnWaqp9ec8S
 HgYySThLhdFF5Wdm6N4eh+D1oRz9h4YdllmY0TFM69xrGo0SJ+5RytlndJoUaO4fXqer
 x/lN9W6WvDDVo2uxIFd3NiW0FuVFvtySeannOQYwiHSZ/BJFO4EMredMZK4lMRSZoEYt
 uQVQPcUOlvKVkCUHOJxzxInlOTNjh4Zsa7MP/D00W+AuTmaePk1my9SanOp80njMWxPk
 zGUGvZz5GBLWr5v3aof3xTRm5EWUHOQ2VPpn07FTlrwZzJK8cxa5lOo06HocJJ8JXQ9K Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2h7ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 11:06:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22UB1j4N114709;
        Wed, 30 Mar 2022 11:06:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3020.oracle.com with ESMTP id 3f1v9fkw0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 11:06:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxDghnZdazE3dG8V7ZyHwY28L+4FhL4VNH/7MUPjoe8Ds1+UOmdz5e5OA4WwH13CI0WnBfExdeccrFPut+b+0/1daVIZmoUABJd6xyNaWsml2CcDcgR+v3Iq+8QUaBNbV4GqGqNm9wbfdkxt+IyN7BRziLtnU8MChlO6HIYSrAeuEq7GkOfCyvIUbMYHf3nHxD4zCy1BjUZPaySeG6790UZm6nhbTp0s5xQk3Zd5DKPWEFRh/0R6lqiwfSnbrIUmda/kNSPpqwWAgy2raTUjLcFreAfF9717iJAch1kq/u5W9ytbg0UNm9LzphR2QsmYXGONvAsxfgeiLGtvtPBq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKuY1jzpfVZmTqLNnBH/xp61YmnZGefhZ9J5OeWJ1P8=;
 b=gsVNhp2G5sNGPREdJH1CK53AMExyJugLKqUTsYaBl1xQHXSZzpWk+7tanyDhofduZcRxLh/MA1mHlAZyxMllOvMXRfK51l8cxWU/nlr3fsRpXPqWpYNNubG5/GvtrxUYQNIKz8JgqraCgheqP8pJr76+qwSUVZ8NGE1fhNohG4OBmYgaja/8QtNLCq6VMcF0HVwBeLUDVG96/tLxP7mUyprqw8SJ4ZlgQT5+MZD3h+jNBQ5OhhJZAwVmJXVcpsjv3LnvWHt2JvGOA9UX4jtbOGw/nMdjqKM2t6P1pfVnCBpbG2ifXVO8AQhSkKETG8jLvl44F2N1FJPX0sShgA396w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKuY1jzpfVZmTqLNnBH/xp61YmnZGefhZ9J5OeWJ1P8=;
 b=b2nB/KeLt6I1KcmpV2rXLqFjyj5UhW9ixJU1Ia8W4ZjbALywEIN7XpaO2LOjYx+9icQPppkI3kJtj3JMKk36J5apdl1a4lFDbii+dQXywJ3gbvQZkqBX2uPV1CDqXO5aP5ItI+GaqmnF4PwLyuYBAZRzWV2xXouHk6KvueGiIxA=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by BN6PR10MB1699.namprd10.prod.outlook.com (2603:10b6:405:a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Wed, 30 Mar
 2022 11:06:04 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::9991:af0:95:7c7c]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::9991:af0:95:7c7c%7]) with mapi id 15.20.5123.018; Wed, 30 Mar 2022
 11:06:04 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>
CC:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "zhengkui_guo@outlook.com" <zhengkui_guo@outlook.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH linux-next] RDMA: simplify if-if to if-else
Thread-Topic: [PATCH linux-next] RDMA: simplify if-if to if-else
Thread-Index: AQHYQqUW7RAC7/tsRkWf8/UgsLthVqzXxh2AgAAA4QA=
Date:   Wed, 30 Mar 2022 11:06:03 +0000
Message-ID: <76AE36BF-01F9-420B-B7BF-A7C9F523A45C@oracle.com>
References: <20220328130900.8539-1-guozhengkui@vivo.com>
 <YkQ43f9pFnU+BnC7@unreal>
In-Reply-To: <YkQ43f9pFnU+BnC7@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64fedd3f-55d3-40ad-4220-08da123d4835
x-ms-traffictypediagnostic: BN6PR10MB1699:EE_
x-microsoft-antispam-prvs: <BN6PR10MB169925085231C4156A122AF3FD1F9@BN6PR10MB1699.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wDAvW7H+EJ2f81woxoJ68/re4iHVnIOoqnpR3oCFsrPL873T1rcRqpCSpjGVEhQ4nhvfOKTm5kySIY7bZKGEynySCLrYRWDNCMNZbEUnqMwW9adssMA4USBsEqWW/DbdOp8RXELG1z6Ct6wxb76QLiS6H7wrsgVd9DS/bttpGTO4oGVUNDas9Cuo7A91KsMpqk2dX6B8uQdJuG7YoJf6NeTvy/aESsLKjNm66R26Vh4Dq/S2CvbreP6eulpyww79H+yNAnhlfJeinFomHP9dxut45pGH+5FYK56iP0QnmBmalGx9I/VblMp05ly1630BiF62RxXDCcx4w7TC3IXdgN2XbkDYPREDrOexbAvvL2Ux8gcKs4UJ9EipNMEp8d0y+rw9wDg1QNWl/e1wAX23FxrSsngu9iMtJohUgasYnzwpbAcb8zhF2T8QUgFzB6zMyEXnp1xUz4bdx5+biHxlnwumalrlxo0VGimEnZ6PmmpeARcBEgTXCnGgtS2rWTfAK1yGPUjNSpw/InjdiLPUODBMl1vqagJ/c2tE2T/DNCPIqX1s86+ukKjWhDvypXQ7NZigcHUCNeQRTTwsfi4G8GI1Dp/n0nDwDe6qJmCEa7S4T5tAd3X91JNDYR/6PuVqYmnETakz8na8nECbB9FXIoadhPg7a5qPA7rmuQpHpTjuQxSfdvZTqtZj9sCgxfNJBL7ZjXTWL8mUMbO7w4bu8KuAoL91120SLJ+ZyJhexD5I9xf2VOYqU1jbpbsLVG6H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(2906002)(54906003)(122000001)(6916009)(71200400001)(316002)(38100700002)(36756003)(86362001)(6486002)(8676002)(2616005)(44832011)(186003)(4744005)(33656002)(8936002)(53546011)(6506007)(508600001)(5660300002)(91956017)(64756008)(6512007)(66946007)(66476007)(76116006)(26005)(66556008)(66446008)(4326008)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0NwYTNRZnNVb3VaVHFpSWVQYW9heitSYlNta042eDllK05wUXY1VWRUQnhn?=
 =?utf-8?B?S1RQaWpYREIvaXFMVnUvZVlIdzc5S2o2RlhaWVQzZ0hydWQ3M3FEcEJZampj?=
 =?utf-8?B?MGE1cHR1ZURBQWZQa3haaWRoemVLSEtmVHdwUnN3ODA4Y2grUll5anlUZXBJ?=
 =?utf-8?B?MSthZlNoSDNGUDJiMGdMdzlGVzRHam8xOWlCaW5iM0MrMzRqTmhZRHZuWlZR?=
 =?utf-8?B?eXpyZm9EN2lFdDVpZ1Evd3E5ZzBzMkpJaDBDN2VFbTJ0QzNXeW02SmxTelQ1?=
 =?utf-8?B?ZENMc1ljSUw0UkJKRit5RzFWZnlHMUxqK3lURFJCNXlxZUdvemF2NzZTV0I0?=
 =?utf-8?B?V1ZYa25EbWtuVExXa09STWQ1R3Q1NGl2aFJxR1ZoVXRoVFc1UGtUM0Mvb3Ay?=
 =?utf-8?B?SmtVSWluRnM4aFZhaUJHVG44QXJZdm0vNFBhd1c5OE40M3oramh3L0lHTERS?=
 =?utf-8?B?NTgwdnoyUXBmMDNMczZmSm1TNGo3eS9WRU91akNGTHFhTUtxUVpIUG9MdjdH?=
 =?utf-8?B?cHl1alE0TWs2YUEzak1QVk9TMTZFdndhcnN5WEcvbUd3L3VvWi90WU5VQmtp?=
 =?utf-8?B?QkE2V0dzN0xKeU5qa2ZuSm5PMVUyaW9vSklnd1FoMnBQSnU2cGtNMERGckEz?=
 =?utf-8?B?MXRwSGt1MW5FL0VkWG84TW13cld3Nkg4RUJUb1VpWkRmOXZ2R2FOU2hKQldl?=
 =?utf-8?B?czE1b1ZTOWJJbDBValhqWGtxZUJETXQ1aGhkUXVVZ1VnY0lRejlPWVFxOTZC?=
 =?utf-8?B?K0ZnZ3hiNERQMWtEK3VFa1puU0ZoOXF5cHl2Q0Y2a25taVR0bkYvcDEvSWx1?=
 =?utf-8?B?ODJHSHhPN20veXN6TlI5TWRRSUdqSGdIRXQ4ckZwVnFLR0dXWWR1ekFSRGxQ?=
 =?utf-8?B?K3d5R3c3aG5wOTFTMEpsNVMvTTBqMFN2QlA2WVljMlpBQXFZcXViaHhuYXZK?=
 =?utf-8?B?TVd4SmJHOVE2NTRFRkFDTkw2Y1NldUZzYmMxMGx4L0dUZjVORnRRaTZTTHp4?=
 =?utf-8?B?MzJIRDFNc3ZQU3BqQmVlem1CYjh6b1FwWFlSUWFpYytsOWYzZkVTdk01WlJM?=
 =?utf-8?B?Vm8xbzZxMmpHb0JlYVl0TUlqWVNIalZ3cGhsNDJTOUFPZVQ1WlpwSG9aVjRT?=
 =?utf-8?B?T2RWYTA5dUlGdVJuK1lNNGZpMVdybjlkT2RTNEd0YXdzNmUrZTQxQ0U4ZkpI?=
 =?utf-8?B?NGlwWitwcHp6N1c5TDRjMjN6M3lkYWhQL013bytoeENxWTNIWldUaGdFclB0?=
 =?utf-8?B?eHdQUDhXQzFRUmtHdlJRNXJ6UDZLNE1RSDN0ZlBBQ0J2eU1KZGZsaFlSNDdT?=
 =?utf-8?B?WU5jaWh4U1ArSGNQVHJBN3VnSHo5cnZzTFhZOU1Ma3FIRUEvUTdhUXVMaDRL?=
 =?utf-8?B?VFgyczMwWkMyNERpVnVDN1BJc2k4eW0xbXk1NTB6MlprNlg3VU15SGhwL3l2?=
 =?utf-8?B?eHQxY0o4cVg0Q1lUckNJa1hUQWRWTmtBU1pKZUswcWR3SVFEZjhsWVpqZDZT?=
 =?utf-8?B?VGRYVFY5aUNML0wyejQzWjNEcnpYR3IrRG0zNGlZSWU1dkZjb0FwbDIvM2dx?=
 =?utf-8?B?NkR1UUo0czBhZ1NUR1h5RWlqNUc5UzhkQ0J1dlRnblNyaVI3QkxtbXBER1BQ?=
 =?utf-8?B?NXJ3SFRTS2JoZHJwMnpSbnBYdlVlbDhGNzZJMFRQcGVBaTdZeWFNbjMxWkg3?=
 =?utf-8?B?MHdvMktYUlBhZ3RJSThBV1FhYW9nT0tOTURaRGdBMVNiVFdtS1kvVkk1TGFS?=
 =?utf-8?B?NVVMY3EyM2NwRzNIU2hZVDNJOUZRUEZSdWdpV0FtTWJNU0IwUVBzT3U1ZUZL?=
 =?utf-8?B?NUNGVlFDNW5rMmxSKzZwK0N6ZGRBUjErVHJrUmczSlhxT1IvNWxvRC9TbTJD?=
 =?utf-8?B?Y05qNlZraDhXbkhlK09KUDVIVm92NHBuMXdXNXdEbGxUUUMvWVpzU3FCa3Nk?=
 =?utf-8?B?RUQzYkp0anY4R05YcDBIeGJnbi9icjA4R0o5QTFGT0FzKzNkZUFHUmNrZmE3?=
 =?utf-8?B?d3NHT2MyOEJ1eWttVVgxQWpjMUkraVpna3c0bjNVRDNFSG5VUG5TUmE3MVRw?=
 =?utf-8?B?THFPNlc1dkpiWVVncWV6dEJNNE9qTElDeHRLWlMycGdKdWJJS3hQc01jckQ5?=
 =?utf-8?B?N2hNVjNRYkNwR1Q0VkFlVlp0WnBEc3kwK2xzclUzanhrVGtqRUIrbFBVZVNa?=
 =?utf-8?B?OC9LZ1JkS3FTeUlpZnJQNGRIREUzQ2srell3bjNpQVZkREN6WU14T05mRHUw?=
 =?utf-8?B?ZCtsVTRTd1luVncySmx4bWxLVXd3Yk81Mzl0RVJOODhYc0FGQ05TbXZpVVNy?=
 =?utf-8?B?eTgrMzFTM3pTMkw1TFhPY3JDMEIwNFQzcklLODNWU1VaRW5xNlN0USt5WEE4?=
 =?utf-8?Q?wOflHy+XYSqJlNTg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38FD06957E8A844D8211CF9101AE2161@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fedd3f-55d3-40ad-4220-08da123d4835
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 11:06:03.9476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jw8lMQP59NnwkQXv1YiZiP1Pg4mfaz0E8dpOg3Ec3ZAnigqOJ3pTEW38S5XqF0d+VuGkX/K5cbLRxVe1LWQfRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1699
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=854 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300058
X-Proofpoint-ORIG-GUID: FPvPgjYA2-NZe3n4r0ZJKtuVBiO5wd6m
X-Proofpoint-GUID: FPvPgjYA2-NZe3n4r0ZJKtuVBiO5wd6m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMzAgTWFyIDIwMjIsIGF0IDEzOjAyLCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIE1hciAyOCwgMjAyMiBhdCAwOTowODo1OVBN
ICswODAwLCBHdW8gWmhlbmdrdWkgd3JvdGU6DQo+PiBgaWYgKCFyZXQpYCBjYW4gYmUgcmVwbGFj
ZWQgd2l0aCBgZWxzZWAgZm9yIHNpbXBsaWZpY2F0aW9uLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5
OiBHdW8gWmhlbmdrdWkgPGd1b3poZW5na3VpQHZpdm8uY29tPg0KPj4gLS0tDQo+PiBkcml2ZXJz
L2luZmluaWJhbmQvaHcvaXJkbWEvcHVkYS5jIHwgNCArKy0tDQo+PiBkcml2ZXJzL2luZmluaWJh
bmQvaHcvbWx4NC9tY2cuYyAgIHwgMyArLS0NCj4+IDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4gDQo+IA0KPiBUaGFua3MsDQo+IFJldmlld2VkLWJ5
OiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0BudmlkaWEuY29tPg0KDQpGaXggdGhlIHVuYmFsYW5j
ZWQgY3VybHkgYnJhY2tldHMgYXQgdGhlIHNhbWUgdGltZT8NCg0KDQpUaHhzLCBIw6Vrb24NCg0K
DQo=
