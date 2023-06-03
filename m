Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C727210BB
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Jun 2023 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjFCPMs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Jun 2023 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFCPMr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Jun 2023 11:12:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B356DD
        for <linux-rdma@vger.kernel.org>; Sat,  3 Jun 2023 08:12:44 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3534EjhT020832;
        Sat, 3 Jun 2023 15:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=LUej8X1X4EPXxqEREyERE/k5U+DGrpzVOwR2TQbhrnQ=;
 b=bOwNs7lvcJuQzS7d0HuCBneYBteWRfSV4WZl2C0z+aJFy+Cq6UTDXmd59SOBJ874c1ti
 yYInh6wM+LB4CIzFF6bsojy2sl4KakcikewxiLJzsrjTl6b5Q0jr2NGE6hqVOVBxqnCK
 2Goljcwj9Y4BATDzVe0QGUadB3CGUUx5Qdtih5dWEzeGRS15HGG8oRt0SNRmlNwexCrt
 wMA1olGsQhFbyDABZXAvIe/5/4OtVgp4oCyD6uCJHWRRf+v6y55ETjLJGmEOvUdZqm3h
 N3447FoMeOqd2Xczjm6SxR5r/D3gJ4egdjk0Hk6cyYPhAzJ69UaW1z7SQ/uO/C6e5Il5 Qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx1nrkad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jun 2023 15:12:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 353BRkYd035239;
        Sat, 3 Jun 2023 15:12:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qyuy7ukwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jun 2023 15:12:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddSkF9Fqyna87blJ/PKKbbuS7qMcBZSty3d6JP1SEWj51ElZyJAhHCNsXuFiAmxgnGTq0J2V3zWBwG/lmoUo1eKjsNkzv2DrK/CBoG47cbJ1UHOlojkHbyP4TLKL8H4PWBSnIfHjwt/IRLU+bjvhXISbP12wIEMS9dW8KWH5nquNrNZ5nkbhzZvvuyzT3Wp6sDYeWkHB6SpQle+oSohldaQz+q7sFKcbjEkrJQ5OI3ALBWhTM7+NN628yqZR19R3FVEiO4rniCj7yjMUErmMct4Kj8KBMl604zxYVIyyFxWZU/DxvHq7LcXd9htL4FiZ/gdbySf1TIijvz28E9jk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUej8X1X4EPXxqEREyERE/k5U+DGrpzVOwR2TQbhrnQ=;
 b=QeWoJDOqXoT6TbliTKob7aHA4Zekf5oWCvNMPVmL+xhs4sy3xTKzJZF2C733VZrgWZGLn3CTz6N5S89Du3IHp4ywQ3RNenIWHTWof89P6jTHb1FhGPAcxWxM5ETRTDTtaol/e/kA+Q4jU4EOxDdt9JlGQMBm67I68G6ksvNCQsnY6K2Agxem3BZqPCONOhUI1KilSqRLzN61sQRDTRy3s3nAobeQjiHTgwfzNobjNYJ64NoB1Heq1BzjLaWKmb4r7+Iww2LSMyQDLOlDfC1TKPlTXrxV+GPj6eNfctWmqJnJ1FGPn+UEQJHvSSsHiamyaDYN1n2FEzRLOAVdLVIwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUej8X1X4EPXxqEREyERE/k5U+DGrpzVOwR2TQbhrnQ=;
 b=WtZqdwoByUzoyHb7+3829U9hWxIIkNYvway77BzEsMvG+A8CNljiK8yymA75S0GygnmLl2+jl7gylQVH/8NFln77AUYrZwE9Cyd0qP5LG9kZHF986ZRVSUOy6OoWpZdrjCUBmsMQa2QqkgceZ5J3lqN9Jm+aRXxALZMb9dtgsrY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7559.namprd10.prod.outlook.com (2603:10b6:a03:546::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Sat, 3 Jun
 2023 15:12:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.030; Sat, 3 Jun 2023
 15:12:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Bernard Metzler <BMT@zurich.ibm.com>, Chuck Lever <cel@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC] RDMA/siw: Fabricate a GID on tun and loopback devices
Thread-Topic: [PATCH RFC] RDMA/siw: Fabricate a GID on tun and loopback
 devices
Thread-Index: AQHZliMZ/D0shCgk30W/e0M9Bx9eha95G54AgAAAlYCAAAnQAIAAA88AgAAFgQA=
Date:   Sat, 3 Jun 2023 15:12:34 +0000
Message-ID: <2CFDE959-9205-45B5-A678-FCAE4BF955B0@oracle.com>
References: <168580052064.6320.4273961644261511156.stgit@oracle-102.nfsv4bat.org>
 <SA0PR15MB39194A46F4CAD3322221CE19994FA@SA0PR15MB3919.namprd15.prod.outlook.com>
 <D9A02961-BE4A-4B71-8FB5-6A0662853BBB@oracle.com>
 <SA0PR15MB391953A7D6B68E48F92C2DBB994FA@SA0PR15MB3919.namprd15.prod.outlook.com>
 <7b88e221-3cb1-aa50-f346-0a7fe9349956@talpey.com>
In-Reply-To: <7b88e221-3cb1-aa50-f346-0a7fe9349956@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7559:EE_
x-ms-office365-filtering-correlation-id: f211995a-d00a-48ff-56ab-08db6444f59e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JK7QmZezZetGh65MsGRsEX+Dyvj5MFjeswGnRsRhT7IDhbXQ9XVHu85ruA2ETCFnpOdFZas9pmliDd3qH/K9vQer72jcRpqiA2HMdDa5VawjB10iJ7al8koL2Cx6UDZ+NzezORPH2jHzubKpx3GHLHL271WYb3GVxgY3qhms/7d5AR2gC0XTJQm4cQC+MQpfk8LcLy5FFThIfdqWfZMgFaSI/Io52cIEk8vuQX98kce8+UV3/qj7Uyhxw2+xFURqFuytfF85ZPMq7GTEQoYOGueLRg+iwDdXwnjzvTfKs7hDFG4XDz3qe4oPiTnwL/vCOSeJVsTXqTbbgtQNf/XLXOLSK8ZpVoOPdJyUIGPy5Kll3NrRnw1vHUDUd4gf7TVSV8cX5Epezs5htymRv1WjhLtUH3E3WxpGIPP8TMtEKsuuFvIMm9lRc3a3nXv9kpu01JdDAFdmpCrd0/yj26n/pI46ImmM0foh/L5SXNww8mrmO2GYY5pFnlbLT6hepFtT7UhNk3Qr1ETz+sJNaoyWM+RlFzS1MgnHqpExKb9gNCfd0eHBgy6JYiaAFoYK5LfJs83o4kUNUxYfLFkWsLp7ftxWkdFZX0LMJpAhxnpVMbkVa+zq6Q10sNvOQ+DtDFHlSA6k9aTDIaglI/zOBLCS6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(6506007)(26005)(71200400001)(478600001)(2616005)(86362001)(36756003)(53546011)(6512007)(6486002)(186003)(33656002)(5660300002)(38070700005)(2906002)(316002)(38100700002)(122000001)(91956017)(41300700001)(83380400001)(6916009)(66946007)(76116006)(66556008)(66446008)(66476007)(54906003)(4326008)(64756008)(8676002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iKqinF2b4Se4FwK7Ay4Xi6ybsdf8CYyHW7EKrg6LVDun+uCd09GYqRg1wf8W?=
 =?us-ascii?Q?Ihoxgc8nSvpej98n6taiDiJ0pfrLY5XSayhiSz2QlA4w0ZDNUdSHdEXan+QB?=
 =?us-ascii?Q?yhnFp/leeKQsPt7EL2n1Ns2sniLdCmLHNJls78umTEYvJY6ZfHG2M6uiLSiH?=
 =?us-ascii?Q?sJKbaHswUHggk1cK4ULorJw0RbF8IEgKB2anzryYuOKutYK2ndppVwI0Gjmw?=
 =?us-ascii?Q?mKcmVuOi48JVIfF8FfODGKMkag0oL/5q+W/9PMF4b9Wx/p+IOrln7W6jvS9o?=
 =?us-ascii?Q?xu1g+qFzuucvKBPi4rkKiUvbjsFEMe+5+eKfEsu/qE6BsQdvWTe/qP3/jtBM?=
 =?us-ascii?Q?9GDZvlfiN79hChhNokmsOC4foRgsjGOqI2hCEevniK4aK4+6Nm9EZoCbtrwl?=
 =?us-ascii?Q?R6CJUmoMUjm7zkFHK6A8JbE/EymvucBUBVPINAU6lrLBY6v9JawV4TQfJUtn?=
 =?us-ascii?Q?onReURjS3jGjiPGw5Nrfu+NJSLl7GYuZYEJSU81acVB80modrL2EdnnIP875?=
 =?us-ascii?Q?OJbuvmXxItAXPphe9o8v01nYRa7qaChugJVg0zNfePArDFQsQAqZ+fYvOrgE?=
 =?us-ascii?Q?vqcKuKdwqw3aE+h8DKsv7tJ0PEA7t66fWqhxo0ktJxD94FUJvOVlV9JIZVL8?=
 =?us-ascii?Q?ObqjQrbHz3Y5UvanKbCKFHZ2/9fUCeZEQDHsO9pI2bXb0IMAZZKj/VkKkoxy?=
 =?us-ascii?Q?tfD7MP8kiEEOJJL81mXZUKGMzG3pBJa0TA1ZRh0mIQXvBlJrcDnQvRWwzHXn?=
 =?us-ascii?Q?5RD1q/eFpgvleR5Vhr2cv5cMD5wjU+UGQ4hx+P6IuzWboLCXQTAhwVGT4we2?=
 =?us-ascii?Q?OZaKzTzty3MoViNOkmBKO25e8PW8dgNRhVfq6bsDZrAetIF0AXzOcY423/T7?=
 =?us-ascii?Q?+OoIMdmUS82Wv4sPT995ft1dPombDRLPtt5C0GLytVxYafeRE8fkoU1/yowY?=
 =?us-ascii?Q?sN36LWeDRfdualwu/qs7nvriald1vS+T0LqH7/vHhJKgY20wMy1YEOOMsvyb?=
 =?us-ascii?Q?8wLE9J0w6IpDqSO5LCwx++GSlw2eXsUxvA0mrQA6mp0V3OgxCBxRhl4Qe/qJ?=
 =?us-ascii?Q?VtF887a3Tf8dJoU09hvHiZ4eH0RVzmg+BHzQVKcIaAm4QswJv56s05HOvPpU?=
 =?us-ascii?Q?87PgtGSUpDYA20j3J04H3cz5OYI9xvSuI//j3VN9jyKKQhkhbBmoviyVwLwy?=
 =?us-ascii?Q?EnpUuiLx1iDwCkwlKEemCOSjyVXO9fFLdx/tdFIaLh5FpWDef2NdpXFgbZPh?=
 =?us-ascii?Q?6kUbHx4/WrWcNzNCD0jAjxy6my0go5O5Do6myTVYzOozZVvBE0isZhQVsLxw?=
 =?us-ascii?Q?ulb+pSidIbTG60i6B+Jujq1xD8FywKER6GK88lWCDaIUnu84eekl+SpEmh2F?=
 =?us-ascii?Q?cnEJU5114UhOZz2UHmQ0JDUdD8pzwHE6xB43Q4p1W+bKKsgWsCn4TlZVqD9O?=
 =?us-ascii?Q?sBAjd4NP/3JAvjzRBmX1gw8skWhYAnkJpPI7nBETog2x4Ud6jOlpI77zC/AA?=
 =?us-ascii?Q?XLwukYJ2GfWoDWLs/2YHUBKrLE38dZ1WEtPMMKmbs2yFbODHnQmfOLTfTlSZ?=
 =?us-ascii?Q?9JqV+ClxEvf+WYqubut+dpDDCL5PuqnhRPPFw1GmLFhfvszB1NiXqUf2CdS8?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D74E08346735EA4494257FF714776385@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qhpuEWjg8gWMpH5KNMSEiazzOsPy6EQpyp+GgMS8lEZw4hxRPgkhBai6wIKjNWtUquJh5jdLSACikxjIwkIKP2CKJz/7a45OCYVCk4FZbq3JB8MePk3vfWCRCAR/hp/eo3x72rEDLT1pGwB/dxg5v2V34B0MdjAKENKgTrCQ8yjkmDidy/dFOB3LcHTrMaw7AP2yH6vSduZAOi/yfnjY51gvjK8fUxG7ioFUF8GdO+shnUHMHGChTp6IcRgIN3R9v+b8cE4aJPBV8S+VZjXWu8Z/UPMO/nZjCVZNMqLzSylOZJE41FGkw/im4HJBaq83est0yxSyVurLLPghBA6iOI/5wZqWUR39hTineJoW6ZKhnSPGs0EckOctS6FJXrFHXOn8QxMvx9X/wseMaG6+3KuJE62SQ1BTXeRt5RMnvBNT/ImGxYZo+R959aUOTYIazO4hD+Pu2qjAQ+foPjEqJvOV2j8aV8SKGoHDILIBlgru5snFvHtTlVggRyK1BRdFoypCMzskA7UAjoH0NM3llCdTdVzEc0XtjSr738bMDo2bd6/UKrF4lkaBMawv3YqEdANsx6oaxYHBLzdvPl5wsHsMnTvYXKi/UFOczdBqGQ9naTowexupPYAi9ZG3uaAwUWFCkplMKmPK4lr07IV7pLa1ykHaltp9kCASfDLS6Oi519HlDU2/f5CBQr04ZjvUuYPHqKIvsM8zt6yVpXGZB1EWJgp8+MNbUuL+AfGJHD6f4M6+/xY/TgUl8iR5f3tah/rqNyBfxfE0bFSJvKfQ75JULugR33fqFM9Tj3rqF7DaHP7mOavEIbNf9UbKeGBkNclJxg+b9jku8gj/+hX8b7tcVlQO5gXrnVeG+nnOwYs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f211995a-d00a-48ff-56ab-08db6444f59e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2023 15:12:34.3978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GypMSzJ7nK8Yhk1QuCRU6hwSHKQPD++7PWXCSvAZL+d4FayJgBVv7ywF6pVelTx7ciy5HxlIh37A7RMAgQKoYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306030138
X-Proofpoint-GUID: E-6LFMKMEd7juOS_aonsBk4W4AUTWfCn
X-Proofpoint-ORIG-GUID: E-6LFMKMEd7juOS_aonsBk4W4AUTWfCn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jun 3, 2023, at 10:52 AM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 6/3/2023 10:39 AM, Bernard Metzler wrote:
>>> -----Original Message-----
>>> From: Chuck Lever III <chuck.lever@oracle.com>
>>> Sent: Saturday, 3 June 2023 16:04
>>> To: Bernard Metzler <BMT@zurich.ibm.com>
>>> Cc: Chuck Lever <cel@kernel.org>; Tom Talpey <tom@talpey.com>; linux-
>>> rdma@vger.kernel.org
>>> Subject: [EXTERNAL] Re: [PATCH RFC] RDMA/siw: Fabricate a GID on tun an=
d
>>> loopback devices
>>>=20
>>>=20
>>>=20
>>>> On Jun 3, 2023, at 10:01 AM, Bernard Metzler <BMT@zurich.ibm.com> wrot=
e:
>>>>=20
>>>>=20
>>>>=20
>>>>> -----Original Message-----
>>>>> From: Chuck Lever <cel@kernel.org>
>>>>> Sent: Saturday, 3 June 2023 15:56
>>>>> To: Bernard Metzler <BMT@zurich.ibm.com>
>>>>> Cc: Tom Talpey <tom@talpey.com>; Chuck Lever <chuck.lever@oracle.com>=
;
>>>>> linux-rdma@vger.kernel.org; tom@talpey.com
>>>>> Subject: [EXTERNAL] [PATCH RFC] RDMA/siw: Fabricate a GID on tun and
>>>>> loopback devices
>>>>>=20
>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>=20
>>>>> LOOPBACK and NONE (tunnel) devices have all-zero MAC addresses.
>>>>> Currently, siw_device_create() falls back to copying the IB device's
>>>>> name in those cases, because an all-zero MAC address breaks the RDMA
>>>>> core address resolution mechanism.
>>>>>=20
>>>>> However, at the point when siw_device_create() constructs a GID, the
>>>>> ib_device::name field is uninitialized, leaving the MAC address to
>>>>> remain in an all-zero state.
>>>>>=20
>>>>> Fabricate a random artificial GID for such devices, and ensure that
>>>>> artificial GID is returned for all device query operations.
>>>>>=20
>>>>> Reported-by: Tom Talpey <tom@talpey.com>
>>>>> Fixes: a2d36b02c15d ("RDMA/siw: Enable siw on tunnel devices")
>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>> ---
>>>>> drivers/infiniband/sw/siw/siw.h       |    1 +
>>>>> drivers/infiniband/sw/siw/siw_main.c  |   26 +++++++++++-------------=
--
>>>>> drivers/infiniband/sw/siw/siw_verbs.c |    4 ++--
>>>>> 3 files changed, 14 insertions(+), 17 deletions(-)
>>>>>=20
>>>>> diff --git a/drivers/infiniband/sw/siw/siw.h
>>>>> b/drivers/infiniband/sw/siw/siw.h
>>>>> index d7f5b2a8669d..41fb8976abc6 100644
>>>>> --- a/drivers/infiniband/sw/siw/siw.h
>>>>> +++ b/drivers/infiniband/sw/siw/siw.h
>>>>> @@ -74,6 +74,7 @@ struct siw_device {
>>>>>=20
>>>>> u32 vendor_part_id;
>>>>> int numa_node;
>>>>> + char raw_gid[ETH_ALEN];
>>>>>=20
>>>>> /* physical port state (only one port per device) */
>>>>> enum ib_port_state state;
>>>>> diff --git a/drivers/infiniband/sw/siw/siw_main.c
>>>>> b/drivers/infiniband/sw/siw/siw_main.c
>>>>> index 1225ca613f50..efc86565ac5d 100644
>>>>> --- a/drivers/infiniband/sw/siw/siw_main.c
>>>>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>>>>> @@ -75,8 +75,7 @@ static int siw_device_register(struct siw_device
>>> *sdev,
>>>>> const char *name)
>>>>> return rv;
>>>>> }
>>>>>=20
>>>>> - siw_dbg(base_dev, "HWaddr=3D%pM\n", sdev->netdev->dev_addr);
>>>>> -
>>>>> + siw_dbg(base_dev, "HWaddr=3D%pM\n", sdev->raw_gid);
>>>>> return 0;
>>>>> }
>>>>>=20
>>>>> @@ -314,24 +313,21 @@ static struct siw_device *siw_device_create(str=
uct
>>>>> net_device *netdev)
>>>>> return NULL;
>>>>>=20
>>>>> base_dev =3D &sdev->base_dev;
>>>>> -
>>>>> sdev->netdev =3D netdev;
>>>>>=20
>>>>> - if (netdev->type !=3D ARPHRD_LOOPBACK && netdev->type !=3D ARPHRD_N=
ONE) {
>>>>> - addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
>>>>> -    netdev->dev_addr);
>>>>> - } else {
>>>>> + switch (netdev->type) {
>>>>> + case ARPHRD_LOOPBACK:
>>>>> + case ARPHRD_NONE:
>>>=20
>>> One thing I'm wondering is if there are other cases where
>>> there is no L2 address besides ARPHRD_NONE and LOOPBACK.
>>> Should we instead check netdev's addrlen instead of checking
>>> the ARP type?
>>>=20
>> I think so. In fact it is a potential incomplete
>> collection of cases where no L2 address is available.
>> Let's make it explicit.
>=20
> Yes, absolutely. IFF_POINTTOPOINT devices (e.g. ppp) come to mind.
> There are a bunch of others.
>=20
> I'm not sure the ARPHRD types are the best indicator. Support for
> ARP is only part of the hardware address picture. In any case there
> are dozens of ARPHRD types, which seems a fragile thing to depend
> on here.
>=20
> I'd say dev->addr_len =3D=3D 0 is a definite indicator. I bet there are
> others though. Volatile addresses? Sounds like netdev may need to
> weigh in here.

That would be wise; I can repost the patch and copy netdev@.


> Tom.
>=20
>>>>> /*
>>>>> - * This device does not have a HW address,
>>>>> - * but connection mangagement lib expects gid !=3D 0
>>>>> + * This device does not have a HW address, but
>>>>> + * connection mangagement requires a unique gid.
>>>>> */
>>>>> - size_t len =3D min_t(size_t, strlen(base_dev->name), 6);
>>>>> - char addr[6] =3D { };
>>>>> -
>>>>> - memcpy(addr, base_dev->name, len);
>>>>> - addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
>>>>> -    addr);
>>>>> + eth_random_addr(sdev->raw_gid);
>>>>> + break;
>>>>> + default:
>>>>> + memcpy(sdev->raw_gid, netdev->dev_addr, ETH_ALEN);
>>>>> }
>>>>> + addrconf_addr_eui48((u8 *)&base_dev->node_guid, sdev->raw_gid);
>>>>>=20
>>>>> base_dev->uverbs_cmd_mask |=3D BIT_ULL(IB_USER_VERBS_CMD_POST_SEND);
>>>>>=20
>>>>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>>>>> b/drivers/infiniband/sw/siw/siw_verbs.c
>>>>> index 398ec13db624..32b0befd25e2 100644
>>>>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>>>>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>>>>> @@ -157,7 +157,7 @@ int siw_query_device(struct ib_device *base_dev,
>>> struct
>>>>> ib_device_attr *attr,
>>>>> attr->vendor_part_id =3D sdev->vendor_part_id;
>>>>>=20
>>>>> addrconf_addr_eui48((u8 *)&attr->sys_image_guid,
>>>>> -    sdev->netdev->dev_addr);
>>>>> +    sdev->raw_gid);
>>>>>=20
>>>>> return 0;
>>>>> }
>>>>> @@ -218,7 +218,7 @@ int siw_query_gid(struct ib_device *base_dev, u32
>>> port,
>>>>> int idx,
>>>>>=20
>>>>> /* subnet_prefix =3D=3D interface_id =3D=3D 0; */
>>>>> memset(gid, 0, sizeof(*gid));
>>>>> - memcpy(&gid->raw[0], sdev->netdev->dev_addr, 6);
>>>>> + memcpy(gid->raw, sdev->raw_gid, ETH_ALEN);
>>>>>=20
>>>>> return 0;
>>>>> }
>>>>>=20
>>>> That looks good to me, thanks!
>>>=20
>>>=20
>>> --
>>> Chuck Lever


--
Chuck Lever


