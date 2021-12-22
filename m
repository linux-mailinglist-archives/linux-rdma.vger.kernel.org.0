Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3747D259
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Dec 2021 13:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbhLVMqP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Dec 2021 07:46:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237086AbhLVMqO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Dec 2021 07:46:14 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMBxbWL031055;
        Wed, 22 Dec 2021 12:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=VcJfEZn7rwkn6EomCmm1ZdmXqM3S+E1lDSwBysuOC7E=;
 b=sq5xXviMGBhTKTUF9riX9VAhARmsshhbarxchAhu9FX7Y1OPmtt2zu0BwagMny4Zj2bW
 haOV93JmY6cuFP3P4+nk/UMWTZvvRBCJln4wbpL5xRP3zfLgRYBuHwLVnX9uKZCnW4FL
 L7iOiAIvqTz0AxVARD9F/SgP75xywspkDajjQrINr9R9uVVtTxAEPBjCYcql01KtE+ki
 juYIUPAmeNpQtu2j4xLCxlpaHuIxsbZ7wSn7EAI+4m8s26arl7nvhXKVuH/dWwmM9PTj
 Y6IBCUFmHHo+36AadqA0DrnhBkczueg3bMEj36Q/tUpOOVfkF+awjYGyrjctm6055zxi 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d3d0r1ugj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 12:46:11 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BMCkBhC003576;
        Wed, 22 Dec 2021 12:46:11 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d3d0r1ug6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 12:46:11 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BMChGoa008151;
        Wed, 22 Dec 2021 12:46:09 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01wdc.us.ibm.com with ESMTP id 3d179awtk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 12:46:09 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BMCk9s923003500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 12:46:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC8E4B2064;
        Wed, 22 Dec 2021 12:46:08 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7CD2B206C;
        Wed, 22 Dec 2021 12:46:08 +0000 (GMT)
Received: from mail.gmx.ibm.com (unknown [9.209.252.230])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Dec 2021 12:46:08 +0000 (GMT)
Received: from m03ex005.gmx.ibm.com (10.120.110.60) by m03ex012.gmx.ibm.com
 (10.187.82.174) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 22 Dec
 2021 07:46:07 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (9.221.46.12) by
 m03ex005.gmx.ibm.com (10.120.110.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 22 Dec 2021 07:46:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSt3yteK91MDafZ1gIK5P5ONKT4Qms8N8qv7Zckjxl1Ianl3Tm+z+xUFvEXnEhUT0VYgHE1M27B1AgLeo1TerZsT2v1YN1scWNLmE3oV4dmO1D3/7zs07Y4WXpeqBAdXrRbbwva+oXXHrxR3x+lnfoYrDXvTH2P7lUHEWCJjM43UCIKaxaeBZRgAkR55GGViLyC+mhI8IBhBw5RY5yfXsCAZ6gRknB4JZu2Lq510x85Mo1AjKZWRincsIlbLioEKA2uhOyNb9aEZ742YJhm0X+1YgQP0ngQKgeHKkf8/zsWwuIQL4OIgyQFrEU6CBIS6JLy/tDvuQQo+fwJJIjJdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcJfEZn7rwkn6EomCmm1ZdmXqM3S+E1lDSwBysuOC7E=;
 b=XHD/uvTzGtIJV/YMCgeaqdeqF6uynJXo9nDJcJ9DolFzVneHXEr5lqUGe0ohQ+yk+aFMRfj57u+6ns+kSz2/pDtoIYXgXlijY+KTQHFkDR9lomQr0JAr4M4cqFNE0HYKx/Juj5TleNl9RVR/JPhpx14QMpV/4JHP+91tieys/fXs1qjElilSns7RDUV1ac5pYbOy5aMIB4p0I4D73RNLrEwcIleIDA9rAMBTfJ/ccer+uMzWSj/fYORLWpmGIBZxnw/lsrsb/RF36AaeKahKX4+AcYpUE2HB3twBBFlMgegaYyiYvY5IVlzMulRNenlV3f//wi4Dl++DVCF6q+XhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by SJ0PR15MB4598.namprd15.prod.outlook.com (2603:10b6:a03:37b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 22 Dec
 2021 12:46:04 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::299f:1ddd:dec0:db9]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::299f:1ddd:dec0:db9%3]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 12:46:03 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 07/11] RDMA/erdma: Add verbs
 implementation
Thread-Index: AQHX9m84pwBFvFOk7EOQ2iwr7NGAKKw9DSOwgADJIICAAJ0EcA==
Date:   Wed, 22 Dec 2021 12:46:03 +0000
Message-ID: <BYAPR15MB263117DA2E661F36741F35A2997D9@BYAPR15MB2631.namprd15.prod.outlook.com>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-8-chengyou@linux.alibaba.com> <YcHXWCJyhIYldpfr@unreal>
 <BYAPR15MB2631D125013B5C4E06C87167997C9@BYAPR15MB2631.namprd15.prod.outlook.com>
 <252268cf-55d6-35b1-3daf-20b231c2d8ee@linux.alibaba.com>
In-Reply-To: <252268cf-55d6-35b1-3daf-20b231c2d8ee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c46eb438-dad1-45e4-6a82-08d9c54903e2
x-ms-traffictypediagnostic: SJ0PR15MB4598:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB459895CF3AFC6AE1CA098C83997D9@SJ0PR15MB4598.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JNr3VaGM2figjzNjRy3RnCQMcaGyvDZEPYAlQMWT5dVqTnGjKilY6zsHd9hhU4A6cPDzK5OQvRJffRphAYR+2K2Nn0tJxKnq0wfcgPFctE8xFGtLlipTqce6Aw8rGQrYUR00Ej54wahYbX4Wm0QmDhRii3kN2Ve4sn5LVapMklo3WskbEhuAzkP06NKAJeKJXd958EV0KIh5X+/xrEPUGCiRf87P0KOM3r2mXxvOk4ZDCHHutU/IvjJUYyCdp63dTkrJadDtTjXbjUmuAH0KedjVTRO+lRtLvjijSJ70x951c1FFVM3nm+p7/62gAXT7Sd5yjVbjgKu6LPS8FR5PcJ45h64eO3hhVLibvOZnZObdVynVgtz2DFURphlT3PB34cID7/WQGhnVEfjEaK0z93Ik5o07JPKprEduw/ZTGgDnZH128MHBuN5frdD40NE/s7+5v2Cnx5VVlUphXdk2NbBj5Lq1uNzjwp2dnrSmRR8YbSGMrMcGKWbU3zYPOuU2rgpHg3wScvCrIw0JXYfOHM9rSOnXrAXPLfwHadUoS0iy+HC2MRMY50+LYASjIbYJEC+XMZ8GJhADsFTUVG+2g9/vaImy+p6bTJ8UwYgjiXvmMFlQsa1ficGX1jpeNgNHnxu4lIgEOntxyLIBWfaHzH9WJD2pLyoS2WijDBi38CbQ/oxl5iHt8XOfYpGM6f6zy0PXSDqx76k8/7yBC6RrAwsNYNB/4+R2mkvA3eOMbl9k8NNiQnTlSvQjamgmtR4t4JZmVoS3mAVU+ivgcAK5s4ML+IKWd/jb6XDgdQRZknc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(86362001)(966005)(5660300002)(508600001)(71200400001)(53546011)(6506007)(83380400001)(9686003)(2906002)(66946007)(66476007)(66556008)(64756008)(66446008)(55016003)(33656002)(122000001)(186003)(38100700002)(38070700005)(76116006)(316002)(7696005)(8936002)(8676002)(52536014)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUgwOWVrVVlHd1I3SmF5MmE2alVEcWQrQ3lJQSt5enI5NXdMVWNzRmYyY1JG?=
 =?utf-8?B?UUN2OWQ3dUNFam1xV29Nd0M0blFxc29VYmNVWlNXWHlFRFNJdDdyby8rQUxR?=
 =?utf-8?B?VTlKQ3dFVGVNcklCVzYrTWVOa2JEU0k4Z0Q0NFNCaWhlWCszNDdUZU91NmhI?=
 =?utf-8?B?OXdIbFVERzliTktORjRsMlFiYnV5S2F4QkdlYXloMnRrL2NMK3g3TXA4blkr?=
 =?utf-8?B?VU5aOWtEaXhzYXFibThCQUNDblUzSWxYbmo2YmI0eTdNNzlxdCtmWVRWNWU3?=
 =?utf-8?B?M2RRSi9iZXZKc281Z2ZEQ3lSZ05MZEJPUStFb2o0SjMwTjN4dGlKOFN0SEx5?=
 =?utf-8?B?R3Jtc1Q4NmZyMVVNUHVvTzQzNVpGT2pGTlQvWnRTb2QrSllDRmpJWVU1T0VI?=
 =?utf-8?B?N1piZm9TcXVadnNlRHlTWDU2NzQyRjEyalI2ZkRvTUpxZkJxK2JSZEhGVjNr?=
 =?utf-8?B?aTVhSjhJRUFGRGF3WHAwckdsSWtwTXFUSzhzTGwwQm5Sek5ucE52c3pwL1lR?=
 =?utf-8?B?VTF5R2hMYUFCaHpCOTlQVm9adjRXWldoR1EyZXJMdm5pRG14ZjJPOVJUQ09u?=
 =?utf-8?B?YVl1bFJMRkg1TDhrRDZBUmFyS1hBbXdlaUFlakJuQTAwU2k2V0Z1SzRNWWdF?=
 =?utf-8?B?Tll1ZU1DSjYyd01GbG1WbjRsUk84ZmhXOVVYdFFZSGpRc28waG0wanJzZHA0?=
 =?utf-8?B?WCs3d09Nb1I1OWxXSXN5Rjd5NlBZOTJML3RZaXQ0eldVSmV6ZWZzSWJkQlQ3?=
 =?utf-8?B?QTJQZjhlMnlVdld0R3VHb0Nsei9ZZllIaDVWRit6UUdUTERCYlR0Q0ZlZ2Zj?=
 =?utf-8?B?RG92UEhaQm1GamRFNmRiSXhpZmFOcE5CbDZDZ1lETUxBcmJzejhnZXFtN1py?=
 =?utf-8?B?NFpPNVpCRXZ4Q3ZQS3NmK1FWYmZsN3pqSW5NOFZRRjRIcmxyZmFpc1hwcXFX?=
 =?utf-8?B?SkRhMzBoSTlvMlYvVHJKcEZGQ202dVV5ellHL0ZLZ25JUDZmVzF4SmFMR1o2?=
 =?utf-8?B?cnQxaUwrT09QR3RZL1JpcXZwNzJoYm93Rm93Q1R2VzlYWG9rajh5bHNsTklq?=
 =?utf-8?B?RTF3YmM5MlJyMDczTVpnT3l2bjMyS1U5RnA0SkZkMDJJTURYazdXMFlIWEVQ?=
 =?utf-8?B?c2ZHcFUzZTVkT1RMeEd4NVpkVGpLMUE3andGMXJEVnZaSzNjVTVtdzdzSG0y?=
 =?utf-8?B?MWZLeWFicTVtcVV5bXNha2R0cnB2UithNVFUUXBBWnNLd3RyMGZkNHBFTkhI?=
 =?utf-8?B?SzVDYitNaS95OEVJME9zYW1BbFV3MzBVT0dpYVBwY2l4NTNLR21BbVluN0E2?=
 =?utf-8?B?aUV4Mmx6RVZyVC9Cc0Y2Z3hmYjVMQWF0dG9IcnlqQmtsSmh0UjFaaFVtSmFS?=
 =?utf-8?B?UXZJdmFzZDZMR2FpSktqY1cxQXQ3UStJU3U1WjJCbDRBN0loZ2h4M2VDVUtU?=
 =?utf-8?B?UWFDazFDUlVQb3Q1a2RzektCa1pVM1dyZnczdkV1RGtKUzN1NUZzT3J5bG1v?=
 =?utf-8?B?ZnJVSzN2Wjh6WUx1YWxPeFVzY3lKbzJYSUsrQ0JEaHZnL1dDSDl4U3BmZTlu?=
 =?utf-8?B?WFpkMTVYbmEwdDRGVDRTeGM1QVVPcElQYithVEEvbVR4QWh4TWZNK0IzN3o1?=
 =?utf-8?B?bmpMU21iWUF3bVFtZGRZUEcrdFNzWnoxNTExREtqU0orMGw5eFp1cTNvUTVW?=
 =?utf-8?B?SGx6cHh6S1NzazVlWHFKUWZEa2NUNy9rZitiZkJkK3BzVHIwNTAyeDdLV09O?=
 =?utf-8?B?WlVWQytEM3FxUUVXTEdOaDl2dmNHRHJ0VTJVRmlwL2k0VnFRSG5LOFJjUjAv?=
 =?utf-8?B?ME5TSW1xc00zNUEvSTNibTdDQ2dZcVAvQXRZTzV5aG5FUExBaEJmYnAwdXox?=
 =?utf-8?B?TnRhb2NsSlBkSndZMUdPVXArREdpUDlQU2FrOU5QRGxZWmtGcWtkY0d3K1k3?=
 =?utf-8?B?NkVnYWNPME9SeTk3MmlOcmVYMjlyOGZSb05VNEZzRllyT3IxQ1FseTdWaDFh?=
 =?utf-8?B?VjU1MnRTRnBVdnFEN1NZS3IySXozaG5FTTJ4YUUzWS9CMGJraU9LRmp6WFZD?=
 =?utf-8?B?QVlnbllVS3F3K3doM0RZRytMR1BvbmoxYW84WEJjelBYUjc0MFg2RllLYnA1?=
 =?utf-8?B?WUwzYWU1MGRpN2wvNmRoVmdVWGg2M0QzbC9YWDVNVnpDNVZSdDA5MjJPMXQx?=
 =?utf-8?B?NWFNS1V5Ylo0NHJOQW82ajJDMEs4Rlp2RE1RQXh3ZDh3QWVRYUVsREpkdVJJ?=
 =?utf-8?Q?TTlGgcnIGxAU9Lnx9TUgjpj8z65W3hubEme1ES3dpI=3D?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46eb438-dad1-45e4-6a82-08d9c54903e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 12:46:03.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoDSr6p9582vJFTFvglanotg/FprRH4WR+eOWgJcq8F6KJqFrXruAA0TJCcKcpRQvHdIbr0fEzZbPjP3RkyibA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4598
X-OriginatorOrg: Zurich.ibm.com
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lr3lcVtpLHq3ytPf24Cre6Ae4QKVbLcj
X-Proofpoint-ORIG-GUID: 2nUq92NEc5Q3GFoqiKAWeqd8k4QwwGd4
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
Subject: RE: [PATCH rdma-next 07/11] RDMA/erdma: Add verbs implementation
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_05,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220070
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGVuZyBYdSA8Y2hlbmd5b3VA
bGludXguYWxpYmFiYS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgMjIgRGVjZW1iZXIgMjAyMSAw
NDoxMQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBMZW9uIFJv
bWFub3Zza3kNCj4gPGxlb25Aa2VybmVsLm9yZz4NCj4gQ2M6IGpnZ0B6aWVwZS5jYTsgZGxlZGZv
cmRAcmVkaGF0LmNvbTsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IEthaVNoZW5AbGlu
dXguYWxpYmFiYS5jb207IHRvbnlsdUBsaW51eC5hbGliYWJhLmNvbQ0KPiBTdWJqZWN0OiBbRVhU
RVJOQUxdIFJlOiBbUEFUQ0ggcmRtYS1uZXh0IDA3LzExXSBSRE1BL2VyZG1hOiBBZGQgdmVyYnMN
Cj4gaW1wbGVtZW50YXRpb24NCj4gDQo+IA0KPiANCj4gT24gMTIvMjEvMjEgMTE6MjAgUE0sIEJl
cm5hcmQgTWV0emxlciB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4gRnJvbTogTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+DQo+ID4+IFNlbnQ6IFR1
ZXNkYXksIDIxIERlY2VtYmVyIDIwMjEgMTQ6MzINCj4gPj4gVG86IENoZW5nIFh1IDxjaGVuZ3lv
dUBsaW51eC5hbGliYWJhLmNvbT4NCj4gPj4gQ2M6IGpnZ0B6aWVwZS5jYTsgZGxlZGZvcmRAcmVk
aGF0LmNvbTsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IEthaVNoZW5AbGludXgu
YWxpYmFiYS5jb207IHRvbnlsdUBsaW51eC5hbGliYWJhLmNvbQ0KPiA+PiBTdWJqZWN0OiBbRVhU
RVJOQUxdIFJlOiBbUEFUQ0ggcmRtYS1uZXh0IDA3LzExXSBSRE1BL2VyZG1hOiBBZGQgdmVyYnMN
Cj4gPj4gaW1wbGVtZW50YXRpb24NCj4gPj4NCj4gPj4gT24gVHVlLCBEZWMgMjEsIDIwMjEgYXQg
MTA6NDg6NTRBTSArMDgwMCwgQ2hlbmcgWHUgd3JvdGU6DQo+ID4+PiBUaGUgUkRNQSB2ZXJicyBp
bXBsZW1lbnRhdGlvbiBvZiBlcmRtYSBpcyBkaXZpZGVkIGludG8gdGhyZWUgZmlsZXM6DQo+ID4+
PiBlcmRtYV9xcC5jLCBlcmRtYV9jcS5jLCBhbmQgZXJkbWFfdmVyYnMuYy4gSW50ZXJuYWwgdXNl
ZCBmdW5jdGlvbnMgYW5kDQo+ID4+PiBkYXRhcGF0aCBmdW5jdGlvbnMgb2YgUVAvQ1EgYXJlIHB1
dCBpbiBlcmRtYV9xcC5jIGFuZCBlcmRtYV9jcS5jLCB0aGUNCj4gPj4gcmVzZXQNCj4gPj4+IGlz
IGluIGVyZG1hX3ZlcmJzLmMuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogQ2hlbmcgWHUg
PGNoZW5neW91QGxpbnV4LmFsaWJhYmEuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgIGRyaXZlcnMv
aW5maW5pYmFuZC9ody9lcmRtYS9lcmRtYV9jcS5jICAgIHwgIDIwMSArKysNCj4gPj4+ICAgZHJp
dmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX3FwLmMgICAgfCAgNjI0ICsrKysrKysrKw0K
PiA+Pj4gICBkcml2ZXJzL2luZmluaWJhbmQvaHcvZXJkbWEvZXJkbWFfdmVyYnMuYyB8IDE0NzcN
Cj4gKysrKysrKysrKysrKysrKysrKysrDQo+ID4+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMjMwMiBp
bnNlcnRpb25zKCspDQo+ID4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2luZmluaWJh
bmQvaHcvZXJkbWEvZXJkbWFfY3EuYw0KPiA+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX3FwLmMNCj4gPj4+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvaW5maW5pYmFuZC9ody9lcmRtYS9lcmRtYV92ZXJicy5jDQo+ID4+DQo+ID4+
DQo+ID4+IFBsZWFzZSBubyBpbmxpbmUgZnVuY3Rpb25zIGluIC5jIGZpbGVzIGFuZCBubyB2b2lk
IGNhc3RpbmcgZm9yIHRoZQ0KPiA+PiByZXR1cm4gdmFsdWVzIG9mIGZ1bmN0aW9ucy4NCj4gPj4N
Cj4gPj4gPC4uLj4NCj4gPj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQv
aHcvZXJkbWEvZXJkbWFfcXAuYw0KPiA+PiBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9lcmRtYS9l
cmRtYV9xcC5jDQo+ID4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+Pj4gaW5kZXggMDAwMDAw
MDAwMDAwLi44YzAyMjE1Y2VlMDQNCj4gPj4+IC0tLSAvZGV2L251bGwNCj4gPj4+ICsrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9ody9lcmRtYS9lcmRtYV9xcC5jDQo+ID4+PiBAQCAtMCwwICsxLDYy
NCBAQA0KPiA+Pj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4+PiAr
LyoNCj4gPj4+ICsgKiBBdXRob3JzOiBDaGVuZyBYdSA8Y2hlbmd5b3VAbGludXguYWxpYmFiYS5j
b20+DQo+ID4+PiArICogICAgICAgICAgS2FpIFNoZW4gPGthaXNoZW5AbGludXguYWxpYmFiYS5j
b20+DQo+ID4+PiArICogQ29weXJpZ2h0IChjKSAyMDIwLTIwMjEsIEFsaWJhYmEgR3JvdXAuDQo+
ID4+PiArICoNCj4gPj4+ICsgKiBBdXRob3JzOiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2gu
aWJtLmNvbT4NCj4gPj4+ICsgKiAgICAgICAgICBGcmVkeSBOZWVzZXIgPG5mZEB6dXJpY2guaWJt
LmNvbT4NCj4gPj4+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMDgtMjAxNiwgSUJNIENvcnBvcmF0aW9u
DQo+ID4+DQo+ID4+IFdoYXQgZG9lcyBpdCBtZWFuPw0KPiA+Pg0KPiA+DQo+ID4gU2lnbmlmaWNh
bnQgcGFydHMgb2YgdGhlIGRyaXZlciBoYXZlIGJlZW4gdGFrZW4gZnJvbSBzaXcgaXQgc2VlbXMu
DQo+ID4gUHJvYmFibHkgcmVhbGx5IGZyb20gYW4gb2xkIHZlcnNpb24gb2YgaXQuDQo+ID4gSW4g
dGhhdCBjYXNlIEkgd291bGQgaGF2ZSByZWNvbW1lbmRlZCB0byB0YWtlIHRoZSB1cHN0cmVhbSBz
aXcNCj4gPiBjb2RlLCB3aGljaCBoYXMgYmVlbiBjbGVhbmVkIGZyb20gdGhvc2UgaXNzdWVzIHdl
IG5vdyBzZWUgYWdhaW4NCj4gPiAoaW5jbHVkaW5nIGRlYnVnZnMgY29kZSwgZXh0ZXJuIGRlZmlu
aXRpb25zLCBpbmxpbmUgaW4gLmMgY29kZSwNCj4gPiBjYXN0aW5nIGlzc3VlcywgZXRjIGV0Yy4p
LiBXaHkgc3RhcnRpbmcgaW4gMjAyMCB3aXRoDQo+ID4gY29kZSBmcm9tIDIwMTYsIGlmIGJldHRl
ciBjb2RlIGlzIGF2YWlsYWJsZT8NCj4gPg0KPiA+IEJlcm5hcmQuDQo+IA0KPiBGaXJzdCBvZiBh
bGwsIHRoYW5rIHlvdSBmb3IgZGV2ZWxvcGluZyBzaXcsIEJlcm5hcmQgYW5kIEZyZWR5LCBzbyB3
ZQ0KPiBjYW4gYnVpbGQgb3VyIGVyZG1hIGJhc2VkIG9uIHlvdXIgd29yay4NCg0KWW91IGFyZSB3
ZWxjb21lLg0KWW91IHByb2JhYmx5IGdvdCB0aGUgY29kZSBmcm9tIGh0dHBzOi8vZ2l0aHViLmNv
bS96cmxpby9zb2Z0aXdhcnANCndoZXJlIEkgc3RvcHBlZCBwdXNoaW5nIHVwZGF0ZXMgNCB5ZWFy
cyBhZ28uIEJ5IHRoZW4sIEkgc3RhcnRlZCB3b3JraW5nDQpvbiBtYWtpbmcgaXQgYWNjZXB0YWJs
ZSBmb3IgdXBzdHJlYW0uIEFzIHNhaWQsIEkgaGlnaGx5IHJlY29tbWVuZCB0YWtpbmcNCml0IGZy
b20gdGhlcmUsIHNpbmNlIHRoZSBjb21tdW5pdHkgYWxyZWFkeSBpbnZlc3RlZCB0aW1lIGFuZCBl
ZmZvcnQgdG8NCm1ha2UgdGhlIGNvZGUgYmV0dGVyLCBhbmQgZmluYWxseSBhY2NlcHRhYmxlLiBJ
ZiB5b3UgZG8gc28sIHBsZWFzZSBhbHNvDQp1cGRhdGUgdGhlIGNvcHlyaWdodCBub3RpY2UuDQpG
cmVkeSBpc24ndCBwYXJ0IG9mIGl0IHNpbmNlIGFsbW9zdCAxMCB5ZWFycywgYW5kIGlzIG5vdCBy
ZWFjaGFibGUNCnZpYSB0aGUgZW1haWwgcHJvdmlkZWQuIEFuZCwgYnkgMjAxNiwgaGlzIGNvbnRy
aWJ1dGlvbnMgd2VyZSBsaW1pdGVkIHRvDQp0aGUgc2l3X2NtLmMgY29kZSBvbmx5Lg0KDQoNCg0K
PiBBdCB0aGUgYmVnaW5uaW5nLCB3ZSBzdGFydGVkIGRldmVsb3BpbmcgZXJkbWEgZHJpdmVyIGlu
IGtlcm5lbA0KPiA0LjkvNC4xOS81LjEwLCBhbmQgZGlkbid0IGtub3cgdGhlIHVwc3RyZWFtIHNp
dyB2ZXJzaW9uIHNpbmNlIGl0IGlzIGluDQoNCg0Kc2l3IGlzIGluIHRoZSBMaW51eCBrZXJuZWwg
c2luY2UgdjUuMw0KDQo+IHRoZSBuZXdlciBrZXJuZWwgdmVyc2lvbi4gQXMgYSByZXN1bHQsIHdl
IGRldmVsb3AgZXJkbWEgYmFzZWQgb24gdGhlDQo+IG9sZGVyIHZlcnNpb24uDQo+IFRoYW5rIHlv
dSBmb3IgeW91ciByZWNvbW1lbmRhdGlvbi4gV2Ugd2lsbCBjaGVjayB0aGUgZGlmZmVyZW5jZXMg
YW5kDQo+IHRha2UgdGhlIHVwc3RyZWFtIHNpdyBjb2RlIGlmIG5lZWRlZC4NCj4gDQo+IFRoYW5r
cywNCj4gQ2hlbmcgWHUNCg==
