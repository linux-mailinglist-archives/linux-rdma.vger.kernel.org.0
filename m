Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD004937D1
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 10:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353356AbiASJ40 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 04:56:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353360AbiASJ4P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jan 2022 04:56:15 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20J8vQDY007385;
        Wed, 19 Jan 2022 09:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=KQyy4vm0lTiS/t/KgDwODQ9mARj17H6GQte0gJsmoZQ=;
 b=eMwE1mmgdDbj0feiqRMsTg96GTxmYyfAMlKxZwbVfqoBqCWIt3OFhVGY0w9aiBo/xp4k
 8dm71ej3EDjb0IDbbN5Fk73ztukMCRDlT24VCkeT8wh8KLC1vWSEqFsPhNWKD/45/tzj
 9Xq75YneePk2/mSHASQTYKJc4aoRmOBHmwID0PNYS3NfsDkf9awDC21eQuScCRa2SNDD
 YL0vyKUlkUVl85igPPpiaJXRz0UKsdhQ1SA5VyT33wZvnjX1mnvxOsn/lQo36il2T6PC
 CjWdJMG/WNK6gGAHSLD3pCfszzi6rVg0NDdQWfz6p4thCHGZmA0Hmmure5yAZtJtxQ5U wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpfkd12tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 09:56:11 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20J9eo8I023669;
        Wed, 19 Jan 2022 09:56:11 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpfkd12t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 09:56:11 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20J9lenS026784;
        Wed, 19 Jan 2022 09:56:10 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 3dknwbdet8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 09:56:10 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20J9u8KD30605794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 09:56:08 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9925E7807A;
        Wed, 19 Jan 2022 09:56:08 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5542878066;
        Wed, 19 Jan 2022 09:56:08 +0000 (GMT)
Received: from mail.gmx.ibm.com (unknown [9.209.244.201])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Jan 2022 09:56:08 +0000 (GMT)
Received: from m01ex004.gmx.ibm.com (10.148.53.60) by m01ex008.gmx.ibm.com
 (10.183.153.167) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 19 Jan
 2022 04:56:07 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (9.221.46.12) by
 m01ex004.gmx.ibm.com (10.148.53.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 19 Jan 2022 04:56:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTKv7J/FGgjfJkujUmY0BmBQs3BLomtS5FacnRE0cEPZoMkQdhda9sLJ7CkqfNqWZGpDid/5FnP+DazVMwheARjDWPqDDxsL9rjFmfDy+iQgsAlROitE8SRgM2JZ69SWN1uZLqyVivdYnK69Ny5VMRo+02tMLl0TvajE/ecjyKdtdUHsUiq4ifwO/gYcwMI0MYwC09oPAnmuF2LCjpI1vrzAA4fn2MjbbydIGMGFyXw1StjQGGc5G3LOZOWeNld8goZbN02HC1lNVbRxEIOliLzeGOTeuuL/l1kt66itRTQmhrV10z3UMrwNTrdSc/nxi1JTUtzYKejxsNKGpNZpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQyy4vm0lTiS/t/KgDwODQ9mARj17H6GQte0gJsmoZQ=;
 b=m4yhV3a39ESwDtXLIS9UnwqYtsYTom89hjr1MHZKwqFdvsecvsH9rQIUV2ZV1M7EpBLMig+gEHqnhF932W871pi3X9RbS7DURKkym4WAWtEcPvgMWC/PXbj3YU5nRR+nhbcKn0RRAOiWsVoM81H/XTHFIP5ztOnZzdfhU3hyEgn6Fs5cXn32j0hZV40WHqOLRafVMiDi1MmnYFz28GwPBRY6I+NuSWKhPgrDQXT7LxNe9MGF5fKK8uJ+vhLw2JWybY2ha7dJ2JnBhH5TXpat6cEs9yADbOekhSxDwT+Kkgau5OZgPB4n0YhLw+f90My1Ys0/faJrcFr5PXg+vta7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by DM6PR15MB4267.namprd15.prod.outlook.com (2603:10b6:5:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 09:56:04 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::31b8:a1ab:2121:fba3]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::31b8:a1ab:2121:fba3%6]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 09:56:03 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next v2 08/11] RDMA/erdma: Add
 connection management (CM) support
Thread-Index: AdgMeqBtsGJoD/PjTiKJhj1QZTS5jAAbidKAAAwDwFA=
Date:   Wed, 19 Jan 2022 09:56:03 +0000
Message-ID: <BYAPR15MB263196636F8243CF6C653DE599599@BYAPR15MB2631.namprd15.prod.outlook.com>
References: <BYAPR15MB26310055D86455FC7088EDB699589@BYAPR15MB2631.namprd15.prod.outlook.com>
 <9f8ab769-271e-32da-1357-7b316d34dc93@linux.alibaba.com>
In-Reply-To: <9f8ab769-271e-32da-1357-7b316d34dc93@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d19d7539-30da-4b1c-7ee1-08d9db31e7df
x-ms-traffictypediagnostic: DM6PR15MB4267:EE_
x-microsoft-antispam-prvs: <DM6PR15MB4267639942C757F66355215C99599@DM6PR15MB4267.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Jwu+OWSsruREKNTb/hO115K7S4q2oMqOKD5TzPJg5NjHaup8HnIsT99Ovok/BW46susnp5XabCrxk/KtsRjDhEO6nNWwZRDzaK9yhrc9VGpASkafTfAn/SVIfsHufx6kUx0LZ/rSgQpBnvhLJUB6Hk/m4bvi732Q0uPb3MBc0CGpcGfPmwACa06ksePICMRJMkyvxGp3xxeDYQ/4im5orLZA4f+o5y/btGwbtiO7n62ySKLrhbecFOdpxyakTIFnrbXRIXnaZc9zkIdKYr1zkQyCaKV+HDZ4xTq9Y85gLz9GlgEuLE7K27x4upgyeRHXDcEAigKfZFAdmHQQViWlLOCW3hBTccsKc+Vp9UszSgQCZVj+ipWl424NSK9xbtwTqKHHZUP9UhpB9fSBGbdNISroRf3TfXeE4MZqR+RoLRzGaImIYCa3qrukR0OlxPPJoB58XilVNxVQVGGbsIoIChZcCeFd5K9qdxtL3LkvF9lQgpS0M39Xy7Hfr4esOPDq1Z1dbRNgYmehzkDU3qwY8giOXmy17c34qIZuP2Lg9ch8iQ2KrRz0S+WOeZDEdrs7CY6XnDYpDHCPNrLzkQf5mrmNyLy1gK1WiIXSy90KLrZYm9GUYGq1kuvZ//iNrWuMOPj2MbHfHAjooW6LyAHq+0XqCMq4GF4bsr0gq+KtllfP7o66Yl2g37qUJyyqYU7OmylRarCvcZYM0RI/4d5pg/YgcOqmoR54LBu3nsgHmTXsvleSK1j+rpdy3SvbYWfFCh/RAmg0HL+xnixVZ5wyQZxjwN83+Sv0PBI/x7LpZs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(2906002)(966005)(8676002)(508600001)(76116006)(86362001)(66446008)(110136005)(7696005)(54906003)(122000001)(33656002)(83380400001)(38070700005)(66556008)(6506007)(53546011)(4326008)(66946007)(64756008)(66476007)(186003)(316002)(8936002)(55016003)(38100700002)(52536014)(71200400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnhyNDFGNGcrZmcvOGhSczQvRDJqTmRidGtEcndQYWlLbDZFdExEY0kyQkta?=
 =?utf-8?B?ck1FTGJNVlVqNE1BRTZ6Ym9BMlc2TGRxSGUxTk5DVmlQNzljN3pYeFM5TUMw?=
 =?utf-8?B?ZCt6Y3pkUEY1YUEvL3JMT2NXeFI4S2ZKSEU0aVQ2akZzVGZRNXcwc0RxMlZO?=
 =?utf-8?B?Y2orSTdpandoZXZXWUZIS3UveEFJU09rVWRBMmhpZjc2RnNQbDNOOGp5TWtR?=
 =?utf-8?B?WXI1RURQMURSYUlERm1lUm5MVVpvNVp4TVE1Vk1QMjAzSVRjWjhndjhTeFVI?=
 =?utf-8?B?V004MzFmdW92aFlLWEN5bGVYQitTdnFJWkNsdms5bWl3bnBlMWFZbjUyc29i?=
 =?utf-8?B?N0xra2dBeXJlSHllRVo2WDA5aDdkWEU5cEx3UE9FdmZ4MUtjNGYvVWI3RWhF?=
 =?utf-8?B?eDNkNHlQcHFVMG1vSE9xeTBhV2cxUEtOOFdpU3kxZU0vcFMydGhZSmNZa0pT?=
 =?utf-8?B?dlJVUjZSZ25XTXd0OFYyMnhEdkhZUVFNZENaUW9BY3BWQTBnRlQ5ZkEvN1p2?=
 =?utf-8?B?M0NCSkVhYi92TUpnNVhXL2w0OW1xelN0b01xYmo0MHVDQUFJWkxYWC8xL2dv?=
 =?utf-8?B?QWVsaEtxM05ITFk0UFdpZUF5cTEyaDZxVUI5ZDFmL1ZnUncxSVlDcENlRHd0?=
 =?utf-8?B?K2JLaHAzNEFESDUrZUJiNDlVSFFLM3JuSFgxMUVlb2pRRHZLa2ZnWFRiZ0tF?=
 =?utf-8?B?MHZPajBNZTBrbEZDUUNOUFhFOWVHcXU3SVFxWFU0aXBHY0J1amQrYjZ4Qkx4?=
 =?utf-8?B?akVvMDhJajA5cHJkNlI3SnkybzI3YURYdjZlTFJaK0ttd1BsdFZOUFhPVFRY?=
 =?utf-8?B?VEVCRXRmejM0M1Z5anhzQnpoVWxUK3hvdnpTZFVHUEJlZ3JvaS93TnplZ213?=
 =?utf-8?B?NzhyWEFZeUlZUzlUOVlwQ3k2TDdldExJblFEYnM5eXdnTDh1YVZzVVk2dkZP?=
 =?utf-8?B?Ynl0aStrS3dJQUYvUmFhMkM3SkZKMSt5MmFNdE5wL09BU2Yzbk9Bd0ZUTXYy?=
 =?utf-8?B?Qm40RnV5S3hFUHRsVjkzNmtPQ3I5VTdjRllwZjIwSFRLdGNkVklmcm5aVjl2?=
 =?utf-8?B?eDB3OS9yUE9CbUZyV2V0cDBrMGk5WjZrTThhTUk0L3NBQWQzWlJ1SVFGV2Vr?=
 =?utf-8?B?T0hNci96dnZUSkxrN2g2RHNXd3pNRmk2WmpUbm1rVUkyZ0c4a1A5RjVrK3hn?=
 =?utf-8?B?YUZiRERUcVRWdmZiRDBBeU5sUFppMkp2LzBsRXJNcE5DWW90SDgvOWpxWTJt?=
 =?utf-8?B?OGMyMTBhTU1GWStLY3RLVTVOWEhMQURVdzE1L2N3MGkxTmdzb1FSMVAzdlJQ?=
 =?utf-8?B?STBwTkVJcCswU0FtdVVnb1ZKVFpqdVU4dG1pMGZ1cGRocTRnYWlscjk2RFhr?=
 =?utf-8?B?THIzMUtScm1JQzdhcy82dWlEcXJnbm1JdHBYMC9RVUFrdEhnd0dSeStZWkFE?=
 =?utf-8?B?UHNkaUI4bk41L1B0c1JFNVo4YWVnOHRRREU5aEZzS2EzR1J6aXdNTExsa3JO?=
 =?utf-8?B?VStFQktXd25tczVBbW1hck1pUTczVXkvSkN5WHp1c3Rrc1ZaNXNiTHVXQlRw?=
 =?utf-8?B?SEJ3L3J4eHJ0R2tvTkhoYlhOTkZ3V0Q1Rk1Ic045VmhWQ29Ma3E3T0M5RWxW?=
 =?utf-8?B?ZUg2YTc2RUthWFNSaHRtNjd2VXFZeEhTL0tseUp5Q2FJTzR3QVljdW56NzBn?=
 =?utf-8?B?aUVLZHh2NlMwUzc1aWtwMHVJcDVPQVMzNWpERGZ4RFYvWUlRWEY3UTJVdFM2?=
 =?utf-8?B?N3hHL0pWS1FLdWNtUHJPWHpWTExWbnpobGVNVk9SUk9IUlVqSG5JdlB5L1I2?=
 =?utf-8?B?QVdTNUdmVjkwU3NydnlzMWtKQzdrdVREaTdidDVRVGtvVEFrN3NaWXJyQ0d1?=
 =?utf-8?B?VzgwOXhRRThpMmRJYVZFZ2lPODJnYk9kTTdrRlFZS05KZGlNU1BUaWJUOGhF?=
 =?utf-8?B?aGY0YkJOZ2RyQ3d2VTc5MFFlNk5TekZQY2NqMEVYaTZpUko3dDg5djA1bHFu?=
 =?utf-8?B?VVAyRk9vOElmdUlyMzBiMCt0dGZRcXU4MEw4YzRvY3E0R0wyc0xhb0pTSUJ0?=
 =?utf-8?B?WXI0ZzEzNWhOcllWTUxzbXRndXRiMmlnZEIvaWs2UHU0VXpxcTBmWjBWY09V?=
 =?utf-8?B?bXEyM3NxckNMcFdSaThuU0pkeWNpWmI4eTZ4aXdwcjBLTlBvYzdoeGVSZHRo?=
 =?utf-8?B?b2RhZmtVT1M2cE9zamVTUlZWWHhXQk01NzlETXpVWFlyUkFLcjlIbWJYZXpm?=
 =?utf-8?Q?4jE1Ch8XQmszPUXH856dTaAPsSwVI6YHhGLQ/Pxw/0=3D?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19d7539-30da-4b1c-7ee1-08d9db31e7df
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 09:56:03.8606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHpVW3J2oh6SeeKShv0nZoiR9sQ1zSQhTPGRw7KdDXAx5UH0qNfFsbijBq8BGAa3aDe6YsxgQwlzUHWrCow26g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4267
X-OriginatorOrg: Zurich.ibm.com
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Nn7gaAh8sK1NCf2_cBZbrVy6rNBZ5ekg
X-Proofpoint-GUID: yt5F3fb4xSD67p96AbUiA7umQheEQpH2
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
Subject: RE: [PATCH rdma-next v2 08/11] RDMA/erdma: Add connection management (CM)
 support
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_06,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190051
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hlbmcgWHUgPGNoZW5n
eW91QGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDE5IEphbnVhcnkgMjAy
MiAwNDo1OA0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBqZ2dA
emllcGUuY2E7DQo+IGRsZWRmb3JkQHJlZGhhdC5jb20NCj4gQ2M6IGxlb25Aa2VybmVsLm9yZzsg
bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IEthaVNoZW5AbGludXguYWxpYmFiYS5jb207
IHRvbnlsdUBsaW51eC5hbGliYWJhLmNvbQ0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFU
Q0ggcmRtYS1uZXh0IHYyIDA4LzExXSBSRE1BL2VyZG1hOiBBZGQNCj4gY29ubmVjdGlvbiBtYW5h
Z2VtZW50IChDTSkgc3VwcG9ydA0KPiANCj4gDQo+IA0KPiBPbiAxLzE4LzIyIDEwOjQ5IFBNLCBC
ZXJuYXJkIE1ldHpsZXIgd3JvdGU6DQo+ID4NCj4gDQo+IDwuLi4+DQo+IA0KPiA+PiArCQljbV9p
ZCA9IGNlcC0+bGlzdGVuX2NlcC0+Y21faWQ7DQo+ID4+ICsNCj4gPj4gKwkJZXZlbnQuaXJkID0g
Y2VwLT5kZXYtPmF0dHJzLm1heF9pcmQ7DQo+ID4+ICsJCWV2ZW50Lm9yZCA9IGNlcC0+ZGV2LT5h
dHRycy5tYXhfb3JkOw0KPiA+DQo+ID4gUHJvdmlkZSB0byB0aGUgdXNlciBhbHNvIHRoZSBuZWdv
dGlhdGVkICBJUkQvT1JEIG9mIHRoZQ0KPiA+IHJlcGx5LiBUaGluZ3MgbWF5IGhhdmUgY2hhbmdl
ZCB1cG9uIHBlZXIncyByZXF1ZXN0Lg0KPiA+IFNlZSBjdXJyZW50IHNpdyBjb2RlIGZvciB0aGUg
ZGV0YWlscy4NCj4gPg0KPiANCj4gSVJEL09SRCBpbiBFUkRNQSBoYXJkd2FyZSBpcyBmaXhlZCwg
bm8gbmVlZCB0byBuZWdvdGlhdGUgdGhlbSBpbiBNUEENCj4gcmVxdWVzdC9yZXBseSBub3cuIEZv
ciB0aGlzIHJlYXNvbiwgd2UgZGlkbid0IGZvbGxvdyBzaXcgd2l0aCBNUEEgdjIuDQoNCkhvdyBp
cyB0aGF0IHdvcmtpbmc/IElzIHRoZSBpZGVhIHRoYXQgdGhlIGFkYXB0ZXIgaW1wbGVtZW50cyBh
IGZpeGVkDQp2YWx1ZSB3aGljaCAoaG9wZWZ1bGx5KSBhbHdheXMgZXhjZWVkcyBhbnkgVUxQIHJl
cXVlc3RlZCBJUkQvT1JEPw0KSW4gYW55IGNhc2UsIHRoZSBuZWdvdGlhdGVkIChldmVuIGlmIGZp
eGVkKSB2YWx1ZSBNVVNUIGJlIHByb3ZpZGVkDQp0byB0aGUgVUxQJ3MgYXQgYm90aCBlbmRzLiBJ
biB0aGUgZXJkbWEgY2FzZSwgaXQgaXMgbGlrZWx5IG1vcmUgdGhhbiB0aGUNClVMUCB3YXMgYXNr
aW5nIGZvci4gU2VlIFJGQyA1MDQwLCBzZWN0aW9uIDYuMQ0KaHR0cHM6Ly9kYXRhdHJhY2tlci5p
ZXRmLm9yZy9kb2MvaHRtbC9yZmM1MDQwI3NlY3Rpb24tNi4xDQoNCg0KDQo+IA0KPiA+PiArCX0g
ZWxzZSB7DQo+ID4+ICsJCWNtX2lkID0gY2VwLT5jbV9pZDsNCj4gPj4gKwl9DQo+ID4+ICsNCj4g
Pj4gKwlpZiAocmVhc29uID09IElXX0NNX0VWRU5UX0NPTk5FQ1RfUkVRVUVTVCB8fA0KPiA+PiAr
CSAgICByZWFzb24gPT0gSVdfQ01fRVZFTlRfQ09OTkVDVF9SRVBMWSkgew0KPiA+PiArCQl1MTYg
cGRfbGVuID0gYmUxNl90b19jcHUoY2VwLT5tcGEuaGRyLnBhcmFtcy5wZF9sZW4pOw0KPiA+PiAr
DQo+ID4NCj4gPiBEb2VzIGVyZG1hIHN1cHBvcnQgTVBBIHByb3RvY29sIHZlcnNpb24gMiwgYW5k
IGVuaGFuY2VkIGNvbm5lY3Rpb24NCj4gPiBzZXR1cCBwcm90b2NvbD8gSW4gdGhhdCBjYXNlLCBz
b21lIHByaXZhdGUgZGF0YSBjb250YWluIHByb3RvY29sDQo+ID4gaW5mb3JtYXRpb24gYW5kIG11
c3QgYmUgaGlkZGVuIHRvIHRoZSB1c2VyLg0KPiA+DQo+IA0KPiBOb3cgd2UgZm9sbG93IE1QQSB2
MS4gQW5kIGR1ZSB0byBzcGVjaWFsbHkgbmV0d29yayBlbnZpcm9ubWVudCBpbiBDbG91ZA0KPiBW
UEMsIHdlIGV4dGVuZCB0aGUgTVBBIHYxOiBXZSBleGNoYW5nZSBpbmZvcm1hdGlvbiB3aXRoIGEg
ZXh0ZW5kIGhlYWRlciwNCj4gd2hpY2ggZm9sbG93ZWQgd2l0aCBvcmlnaW5hbCBNUEEgdjEgaGVh
ZGVyLg0KDQpUaGlzIGlzIGNvbnRyb2wgaW5mb3JtYXRpb24gcGxhY2VkIGJldHdlZW4gTVBBdjEg
aGVhZGVyIGFuZCBVTFAncw0KcHJpdmF0ZSBkYXRhPyBTbyBlcmRtYSBpcyBub3QgaW50ZXJvcGVy
YWJsZSB3aXRoIGEgZGV2aWNlIGltcGxlbWVudGluZw0KSUVURiBpV2FycD8NCg0KPiANCj4gPj4g
KwkJaWYgKHBkX2xlbikgew0KPiA+PiArCQkJZXZlbnQucHJpdmF0ZV9kYXRhX2xlbiA9IHBkX2xl
bjsNCj4gPj4gKwkJCWV2ZW50LnByaXZhdGVfZGF0YSA9IGNlcC0+bXBhLnBkYXRhOw0KPiA+PiAr
CQkJaWYgKGNlcC0+bXBhLnBkYXRhID09IE5VTEwpDQo+ID4+ICsJCQkJZXZlbnQucHJpdmF0ZV9k
YXRhX2xlbiA9IDA7DQo+ID4+ICsJCX0NCj4gPj4gKw0KPiA+PiArCQlnZXRuYW1lX2xvY2FsKGNl
cC0+c29jaywgJmV2ZW50LmxvY2FsX2FkZHIpOw0KPiA+PiArCQlnZXRuYW1lX3BlZXIoY2VwLT5z
b2NrLCAmZXZlbnQucmVtb3RlX2FkZHIpOw0KPiA+PiArCX0NCj4gPj4gKw0KPiANCj4gPC4uLj4N
Cj4gDQoNClRoYW5rcywNCkJlcm5hcmQuDQoNCg==
