Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D70A687230
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 01:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBBAKD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Feb 2023 19:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBBAKC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Feb 2023 19:10:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FC869B3D
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 16:10:00 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311LE8aV007865;
        Thu, 2 Feb 2023 00:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NHAlc/zldIA+QzBQTkoECM2DtsuCWd33ucvIpoQ5PnA=;
 b=Aodzsk0r16uug6G71e+nuWU68JwBZxZYmieWGxdm+smRzftUwQ0GqWAU3WtAmm1/NmBx
 +Cg+6cSdst5z+uhPB94LrYiLzJETrtHd7JPgCvUGiK6wEpXZ0/V6oMf02CITebUaJOKB
 Kv1G0PnAx2lMHktlpCXLoErhU348ITn5FHvt0b2Ikx3G5CNd+SHhqiiuZeJ3RmbXX9Yl
 4T351KgBEAqw4ORtyw5JtU/LUj67Rjt7AaI2Zp03IDQTbtQHDqZECNyT5VkfQ1f9HZys
 tAmNVeCi1awCJs69fYZZZmLUxye5zbsJJ1XhpKfRGOpk9l/fVlRxGq+qJBWz6IonRGRD Bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq28sn8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 00:09:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 311M6U2f036064;
        Thu, 2 Feb 2023 00:09:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct589hs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 00:09:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI35hlWR36xeg8sFlvS1tfa/9KI5ySQX7vbtpfZXenbOndUV42B5oU0AjTHGufTQfCH5vrv49t/+U8JkBkCIYHuKX8FdfKi7UlxE+rf88vIE+ByI0Hxll8paYJN2dysrKhheGXzrLRRgA4t5XjAH5TjCoECpMuipzEtKlC5ChUqrtXS0XkEhcBArDoXCDA8ZiUGptqUgTxjT7FSiKa+eDHnaclEERNfs+gbOHtOr/G2mc9lYSRi4xKKhYjFZOdhHYEAnprbKpITGSVVh8tMuwfwunhs12oD474wdmDT9D9nEFWq7m9902YDK/oKXTvPNtT1qvJvut/9HLah+EcXUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHAlc/zldIA+QzBQTkoECM2DtsuCWd33ucvIpoQ5PnA=;
 b=lmnNwOAghLfDfAc1KVZMHr2Yf6Pzdj/EnFOnwXaywzSue0HS5V0r3qqRnRsfZAjXc28E3Q9zyTsKf0/mxmeJs9hM3rp8/+KUA+CkzSSRgC9GU4NHptYWYfYElVtAt53mEm36d62WyG4wO6xRybFQg3EHv8ijfBr9GY27I/wRCvmwMy8OY/uve8Uy3zoWSdi0mOih2T4VW1RCI4a1pTN/yQNhvHoWOd+AvBJDNoswZprtPWVGXfUV2h8aXGEBzkrs9Ca4eJL263dw7qL6DM4Wn86/QZBL4fG/Oq1c6Qng8y1D4flMTm8tFz3x4PGnPnMxvDxU8qpu47qcxO2LE/TnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHAlc/zldIA+QzBQTkoECM2DtsuCWd33ucvIpoQ5PnA=;
 b=bMlG992zcL8xuRE/M6Yqqa2IPDtKYvI/yjGtM75qqi4UeurYQwCnOf2ZTs70LXZ5cVTUwJhXJ05ZXlxC42YApUIKIOrCkiLuSSqGp/f7Czh5JA+2BWW++zKlL8Wa3SlMfu/VjLYcPQ8PYMRV/nz4nCBCugjvcOjY0rbLe1DaKOs=
Received: from MWHPR1001MB2318.namprd10.prod.outlook.com
 (2603:10b6:301:2f::24) by PH7PR10MB6459.namprd10.prod.outlook.com
 (2603:10b6:510:1ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Thu, 2 Feb
 2023 00:09:50 +0000
Received: from MWHPR1001MB2318.namprd10.prod.outlook.com
 ([fe80::2ca2:9748:6872:f417]) by MWHPR1001MB2318.namprd10.prod.outlook.com
 ([fe80::2ca2:9748:6872:f417%6]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 00:09:50 +0000
From:   Jack Vogel <jack.vogel@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "mustafa.ismail@intel.com" <mustafa.ismail@intel.com>,
        "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/irdma: Move variable into switch case
Thread-Topic: [PATCH] RDMA/irdma: Move variable into switch case
Thread-Index: AQHZNiWGX2M0+EV610KSGXQkQtSaTq66yQmA
Date:   Thu, 2 Feb 2023 00:09:50 +0000
Message-ID: <997C66D5-3298-4F64-8784-3FDAA438C66C@oracle.com>
References: <20230201012823.105150-1-jack.vogel@oracle.com>
 <Y9o6xnalM+R4DE3D@unreal>
In-Reply-To: <Y9o6xnalM+R4DE3D@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1001MB2318:EE_|PH7PR10MB6459:EE_
x-ms-office365-filtering-correlation-id: 16b052cd-06c2-4387-5995-08db04b1cd98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YibhaRvhlTBHBcAi/S4X/Nsu1RRKRs4cl0QC2jdz8/d4UnKxuMI4JO433+cuRE3ALrJrS+FJnFZc2ocpOOlrHVum7SFt3q9gv84QoukAoBeyi1XhQ5p8Z/V5wujAZsMge1WcK4uI92qH4ItNHzGAFq170uR/lkG2nX0pkmzsO4Ajruq6tjNFDG4f8AQhK4imnBbAkEr5w20KXHiuSdsiFl/HmNu8uxxbdo0h5cW6Lnbcn1cn3+YWRA+4LcYupx1c6tTCbXxLKMbQdGd9v3yMGeR5ke7RwrLmeS8GUodJSPLdbsSRmXPH2Z3n1TmVDsZ/hCColFgMG5ecwEzUMST4b4/XVnHjWMNsmg4cFU5k4Iktp1z7GRtJF7iK4BOi8LC/SPN1bh+JxBfgB0SchPokXhlDHqOWSMIEpeNW7S+cJ2f4+2nJ09wNA03pFZZqfOp9FiYuKPr2cgzAydMJsdVorp5aTubvTqWLbQIfgwj81nIEihZRuxZMq6hgeYIK0slNkD9hp6f8prIwnWmze4mWbM05dQDVncKsXc1qfl2B0FS+DmKiPvmp5223tiyt4P4+zaMon1V5HAqlfUn1GaNfpu0e7qw60sI0oERz5kFqOETMPCUFnMkWRePXIBUVCxt6WdfqzyVwfcxKq4mGs24YHvh8TN5wEnlG1t7Re1a/VuvG6CTruC52/yrGqBQgnrw3WbNJ0ehKDelGzm6ARJOuHLK+q47w1Ky4B9JAHMt4yTTSmcTyChl3ou6Ezc17ZbLtdaaNb4Hxh8oY1yEBvuaMZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2318.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199018)(38070700005)(8936002)(41300700001)(5660300002)(66946007)(6916009)(4326008)(76116006)(91956017)(64756008)(66446008)(8676002)(66556008)(66476007)(33656002)(83380400001)(53546011)(122000001)(38100700002)(316002)(6506007)(86362001)(71200400001)(966005)(6486002)(44832011)(36756003)(54906003)(478600001)(6512007)(186003)(2906002)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ukt4RWQrcEZxRUZjeUY0NkRCWU84eGorMndidkcvck1vaEJrZ1VPUkNkd3NZ?=
 =?utf-8?B?OEVPYkZSeW9aRWhjQ0ZBWHEwMkxpc1NXUGtLZloxZ0l5Z0llTHNEU25vT2Q1?=
 =?utf-8?B?ajFiN0o4U0w2R2h1SzZ3eS80bXM2bEkrL1JJd2NUQUh1MmFsMUN1ZW56aDNG?=
 =?utf-8?B?dy9FWWpBbEVBbFRXKzFZNE9RNUo1c3dBeG5FZm5IclpVcjFqRFk0RWF6cXRF?=
 =?utf-8?B?MGJiTWhsTEdIOU4wZ1k0N2dmVmsxbHB0K0VkTHZlQjlQaEdLcnJ2RE0zNld3?=
 =?utf-8?B?VFA3S05NNzFjZW9SY0FPczE1SVF0MzFXMjhNVzJVVHA0YnFpc05PS3NTdDhO?=
 =?utf-8?B?Skg3K3U3TjV1UFRZUGowK0oxNTd3U01UVHRjVmlTbHppT0J0UlZLZzNsdFEz?=
 =?utf-8?B?OE5RK3ZZY3VrSjJPUzh6MkV6Tjh0Q2x4SXFQaDNIaWZicmZWNTNISFFUQmNJ?=
 =?utf-8?B?RTBkb2VwRG85YzMrendXZ2IvRzF2d254cm5BRFB0TGJ5RDRSNGZwUithaE9D?=
 =?utf-8?B?ZG5lalZaTmxQNUF5eXBsYzByVkVMdGhSZXNFeXhqMmFtbEY4WTRjSUQxa29s?=
 =?utf-8?B?VmZYWGx4aHQ2MkpwQkxSMzNtSWppL2JmTk9rY3JsYkVuUWYvVU1FWjBmOVdY?=
 =?utf-8?B?WjJXSFRxT3FyZWVZNThGTGVmVkxjYXVZWnRUeEZVS0JrVXJvc25FeTMwT2hx?=
 =?utf-8?B?aFRZZGRhTjlWME9FUXBjVklFSzJmNGJDUTFEUk1mSlovUmhvMEdHNmprQXpB?=
 =?utf-8?B?Y1ZrUTVTenEyRy9JNk9IUFBQdzlUZG9IUEoremt3dW44a3k2SHBzMy9KMDlD?=
 =?utf-8?B?RWdqeTR2Z1pxR1F6L0RMNFJCcVR6QTVxdlZjQklZdkQvTkhaVGFGa3AzUnh2?=
 =?utf-8?B?M2kwUTZvZEhLWG9JMVJWM2RCOXFlZ0VvdFdIUVZEZ3N4N1V0aXRJeXBGdHln?=
 =?utf-8?B?UkRjMERHR09PNjYzNVZzYXRQQk5uTUluQUNXc3hwcXpvNVBuRDlCcng3WG82?=
 =?utf-8?B?K0orL2I2aDJJb1dHbnkydmgrdUVCcXhxMWZOSnI3OUs0SlhSVWd5elY2UDh0?=
 =?utf-8?B?R1hVditOR2VmMmNhc3lNMW4xeDR5WkNYTEhLUGFMdkhtNkVUV3ArNGF2SjBq?=
 =?utf-8?B?WmNONVJjZ3cvQ1gxcUNjUkZKSFVCWkZKdEpNbGVqYktwWG1MV05GN1ozM0Zm?=
 =?utf-8?B?bDg2TlJMQ3VWRURQTnNxekxZejBKbHZZYWpwZUVZRXdPa09IQ0JUSDNISzdx?=
 =?utf-8?B?cTY2ZHJLQi8rVnpEQ2xxQnVidllZeDZhYXVXS2o2Ymd1WEpNTlZRS0IzaUVw?=
 =?utf-8?B?WjJscE03dVM4akgvZ1UrUjdWUGdIdkhQbjRSK1dmZFhYR1pSK3RWZ1F5bW1C?=
 =?utf-8?B?MzUrT09kTGJFb2xmam53dHlneE15VGhvMGNnWTVhM05Sc0VmUGsyc0ZrNjdi?=
 =?utf-8?B?THlyRGxOR05lWjN1OU01THFwVWpJWEFDQURtMzRXcSs1SXRBUGNrSkhzbGw4?=
 =?utf-8?B?Mit3clJJMnAyUVQxWXd4blhXa1psOWpwMnNONGx3Z2ZEOUF1d3ppUW8rQkZD?=
 =?utf-8?B?VFVTb1FIMzB3enMxOW9CL2NkSFBUNEJjTjlBMTU2WEdmanNha3huRXdreUht?=
 =?utf-8?B?RHNFYXpuVHRSNlNGUE1ydE1RUnNCYkJIeHlqTC9DR3JHRW13MUNzZm9XSkpj?=
 =?utf-8?B?Tm1HV211UEdpV3lFZjM4SFRCMWhVd0ZsdEd0ZTNBNFhWNzBZK2lDZGxncWtU?=
 =?utf-8?B?ZzlLaFpJY1R3NkUxQXNFdU1nQ3dGbEdsQ253STNURjlRbmp5VUJoa21XdVpX?=
 =?utf-8?B?MnE3UncySUlHTVBsZFBTa3A3SVpyb0Z6QXcwY2FIeE5pUnF1cThGWWlyS3VY?=
 =?utf-8?B?MVlaTnJWYWN3K3h2Tk93RTkxQlN6dTdOenM0V0srTm5ER2Zvb2RFU0ZueHFJ?=
 =?utf-8?B?VldWKzVxVzhXWTZuTE5kendyV0FpVC9nZVFreG5pbjRtR0I4K3FvQytXT0ht?=
 =?utf-8?B?RUFwaVcyVlJsYzhYVENHTjlkdXNTVjdHSFJmUTFwWFpjZEExUDBtSzJPTFpu?=
 =?utf-8?B?eUhhRWNTUTZGZ2NSamNOOC8xREVXTUVvb1YvK1BXV1FFdllRc0dQRkRoZXZB?=
 =?utf-8?B?STlEU2NGelNvQXRPc3hiVi9Yb2ZVT2k0ekJzZTZMZEpROWZQWHFNVkJjMlZF?=
 =?utf-8?Q?nrNQ16goePm+2DJElHynXOo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A00F2592DA2B24B82B30BE9229F06CE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a2fsXhL9NlLZaThByNi2P3/Tx9RKtMCAlZq8JWLhLGhpFKwmv1nwyWF/t6imwU0REbgZDrRppU/65ymEzDQJ99CYw6DDcq4yaLVQVbH6K8UswEK4ug2UJk5ggXpN773M/d6ZoZBGcpfFMx7CUfh570upUtn/eiWi66Q/YFFS6H3NaPgdEOYVmgeZQdXJnacGfMDxfNj7ptw20og42ekC9Wlq7BupfaTbshGV/AGvNsEn/N9w5fz2Fu8y/brXKE6qe8FyPfKNTJ5gXO9asG78bqIEEmobv9CQAheFhIKKw9RDK17CxxovwtmHpTVs3u4TmnfxQxeJZWQSQzWNbaYjEkck8Y7Vhw2V19AS59ivBOEzqRAiy86TDfnGJQOs5XJF1JbIesPSE+FrLg7xrvHNNAjL7lJWXBY/e5nsMC3x1hJ19RMYEPUYHK4ovq7sAJvCgFSzMggOpn7/lCE30LauGSbRT0g7Q34pl/ScwySoOAkfFxI6e723eGkiuNiFd+f8WIUXyeOgQvyjwD4E3oSZuo0CODlsQooFWF8FfIpCiKplbzH3fZUDVm3OkGv9Fra3gRhczbICkIUL8gWjLwV7HgcHkJkQl/JMR9vkT+5Xa7Gech2KtBgSOdvNcE/T6efZXXkWGN2KGeH1LrsciUyNG6Tiit5cA13LyMHyIWFfnQ09CwfG218I07Mn1rz+2bZJr/H+Uq8wrv0/TtsLEP+OIIoR36rOwdFngMSChUimNHBpc5EWgC7LrT8l3T4QGB8Kj5rRSc8Tepb5AmvMCsa5NVHGZU6uBciKtHB6u0LemN7o3OCzAf0oUtLSFclNhdTG
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2318.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b052cd-06c2-4387-5995-08db04b1cd98
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 00:09:50.7468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAiSj6JME9fEquE3FMQHnSeyaUQW4R0A16xLr9jj7Qy1yc5Zjfs9FHL5SPDWJwvRwUTwK/tDCaB+SzaqAR36sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020000
X-Proofpoint-GUID: ew8eSF-lij064wMpx4guMNuE7Mz2Tb_D
X-Proofpoint-ORIG-GUID: ew8eSF-lij064wMpx4guMNuE7Mz2Tb_D
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGV5IExlb24sDQoNCk9yYWNsZSBzd2l0Y2hlZCB0byBHQ0MxMSBpbiBvdXIgVUVLNy9PTDkgcmVs
ZWFzZXMgcmVjZW50bHksIGxlYWRpbmcgdXAgdG8gdGhhdCByZWxlYXNlIHdlIGFkZGVkIHRoZSBB
TExfWkVSTyBjb25maWcgb3B0aW9uLCBhbmQgdGhlbiByYW4gaW50byBzb21lIHdhcm5pbmdzLCBv
dXIgYnVpbGQgdHJlYXRzIHdhcm5pbmdzIGFzIGVycm9ycyBhbmQgd291bGQgZmFpbC4gRm9yIGlu
c3RhbmNlIHRoaXMgdGhyZWFkOiANCg0KaHR0cHM6Ly9sa21sLml1LmVkdS9oeXBlcm1haWwvbGlu
dXgva2VybmVsLzIyMDIuMS8wNTU1OC5odG1sDQoNCkEgbnVtYmVyIG9mIGNoYW5nZXMgd2VyZSBt
YWRlIGluIHRoZSBtYWlubGluZSBjb2RlIGJ5IEtlZXMgQ29vayBhbmQgZXZlbiBtYWRlIGl0IGlu
dG8gdGhlIGxpbnV4LTUuMTUueSBicmFuY2gsIGJ1dCBhIGNvdXBsZSBvZiB0aGVtIHdlIGhhdmUg
Y2FycmllZCBhcyBzcGVjaWFscyBmb3IgdGhlIHBhc3QgeWVhciwgSSB3YXMgcmVjZW50bHkgcHJv
ZGRlZCBhYm91dCB0aGUgbWF0dGVyIGFnYWluIGJ5IGFuIGludGVybmFsIGdyb3VwLCBzbyBJIHRo
b3VnaHQgSSB3b3VsZCBzdWJtaXQgdGhlc2UgcGF0Y2hlcyB1cHN0cmVhbS4gDQoNCkkgbXVzdCBh
cG9sb2dpemUgdGhvdWdoLCBmb3IgdW5iZWtub3duc3QgdG8gbWUsIG91ciB0b29scyB0ZWFtIGFj
dHVhbGx5IGJhY2sgcG9ydGVkIHRoZSBmaXggZnJvbSBnY2MxMiByZWdhcmRpbmcgdGhlc2Ugd2Fy
bmluZ3MgYW5kIGZvcmdvdCB0byB0ZWxsIHRoZSBVRUsgZ3JvdXAgYWJvdXQgaXQgOikgSXQgd2Fz
buKAmXQgdW50aWwgeW91IGFza2VkIGFib3V0IHRoZSB3YXJuaW5ncywgSSByZXZlcnRlZCB0aGUg
Y29tbWl0cyBhbmQgZGlkIGEgYnVpbGQgdG8gY2FwdHVyZSB0aGVtLCB0aGVuIEkgZGlzY292ZXJl
ZCB0aGV5IG5vIGxvbmdlciBvY2N1ci4gU28sIHNvcnJ5IGFib3V0IHRoZSBub2lzZS4gSSB3aWxs
IGJlIHJldmVydGluZyBvdXIgb3duIGNoYW5nZXMgYXMgdW5uZWNlc3Nhcnkgbm93Lg0KDQpSZWdh
cmRzLA0KDQpKYWNrDQoNCj4gT24gRmViIDEsIDIwMjMsIGF0IDI6MTEgQU0sIExlb24gUm9tYW5v
dnNreSA8bGVvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSmFuIDMxLCAyMDIz
IGF0IDA1OjI4OjIzUE0gLTA4MDAsIEphY2sgVm9nZWwgd3JvdGU6DQo+PiBGaXggYnVpbGQgd2Fy
bmluZ3Mgd2hlbiBDT05GSUdfSU5JVF9TVEFDS19BTExfWkVSTyBpcyBlbmFibGVkLg0KPiANCj4g
V2hpY2ggd2FybmluZ3MgZG8geW91IHNlZT8gV2hhdCBpcyB5b3UgY29tcGlsZXIgdmVyc2lvbj8N
Cj4gDQo+IFRoZSBjb2RlIGlzIHBlcmZlY3RseSBmaW5lLg0KPiANCj4+IA0KPj4gU2lnbmVkLW9m
Zi1ieTogSmFjayBWb2dlbCA8amFjay52b2dlbEBvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiBkcml2
ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvaHcuYyB8IDQgKystLQ0KPj4gMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS9ody5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L2ly
ZG1hL2h3LmMNCj4+IGluZGV4IGFiMjQ2NDQ3NTIwYi4uZTNjNjM5YTBkOTIwIDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2lyZG1hL2h3LmMNCj4+ICsrKyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9ody9pcmRtYS9ody5jDQo+PiBAQCAtMjcyLDggKzI3Miw4IEBAIHN0YXRpYyB2
b2lkIGlyZG1hX3Byb2Nlc3NfYWVxKHN0cnVjdCBpcmRtYV9wY2lfZiAqcmYpDQo+PiAJCX0NCj4+
IA0KPj4gCQlzd2l0Y2ggKGluZm8tPmFlX2lkKSB7DQo+PiArCQljYXNlIElSRE1BX0FFX0xMUF9D
T05ORUNUSU9OX0VTVEFCTElTSEVEOiB7DQo+PiAJCQlzdHJ1Y3QgaXJkbWFfY21fbm9kZSAqY21f
bm9kZTsNCj4+IC0JCWNhc2UgSVJETUFfQUVfTExQX0NPTk5FQ1RJT05fRVNUQUJMSVNIRUQ6DQo+
PiAJCQljbV9ub2RlID0gaXdxcC0+Y21fbm9kZTsNCj4+IAkJCWlmIChjbV9ub2RlLT5hY2NlcHRf
cGVuZCkgew0KPj4gCQkJCWF0b21pY19kZWMoJmNtX25vZGUtPmxpc3RlbmVyLT5wZW5kX2FjY2Vw
dHNfY250KTsNCj4+IEBAIC0yODEsNyArMjgxLDcgQEAgc3RhdGljIHZvaWQgaXJkbWFfcHJvY2Vz
c19hZXEoc3RydWN0IGlyZG1hX3BjaV9mICpyZikNCj4+IAkJCX0NCj4+IAkJCWl3cXAtPnJ0c19h
ZV9yY3ZkID0gMTsNCj4+IAkJCXdha2VfdXBfaW50ZXJydXB0aWJsZSgmaXdxcC0+d2FpdHEpOw0K
Pj4gLQkJCWJyZWFrOw0KPj4gKwkJfSBicmVhazsNCj4+IAkJY2FzZSBJUkRNQV9BRV9MTFBfRklO
X1JFQ0VJVkVEOg0KPj4gCQljYXNlIElSRE1BX0FFX1JETUFQX1JPRV9CQURfTExQX0NMT1NFOg0K
Pj4gCQkJaWYgKHFwLT50ZXJtX2ZsYWdzKQ0KPj4gLS0gDQo+PiAyLjM5LjENCj4+IA0KDQo=
