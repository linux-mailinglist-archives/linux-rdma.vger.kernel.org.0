Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5F6629F21
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 17:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiKOQeb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 11:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiKOQea (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 11:34:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0053711822
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 08:34:28 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFG24ZL025313
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 16:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ra3DGiqBTuxQFyoRPcoZz98RKyWOJ2Bj/axAAbqJqf4=;
 b=mk/nNae8JKeiZeQOK1eE/9VTRsHvNIvVCP4zKl5ieAMBydlRcmzMSwl8uW7cIYdJp+bq
 aoJBKl4VXKQF4JSPrJ8YB9yfO3mzZ2zbCG0AE1GZNt0y2LoH/rcgbfsPiiQIOMXVtO/B
 JAzmsHTqCX5qJOdxQXhWqW/31YA60MKX66CFTzwTqy7HU8h57MuReskO3/eXrerUQ4C6
 mDYrP3KaoknaacP8SbvuQv9AL4Vq3DQuct994w5Ahb/bYwCaaCCUFoujx/uqtKEwc/tc
 mLghgvT+iA1tyL3A+lG16rrFH9RH+VCEtRFGAwf9/PlYBhPD0EqbycpPRH0TOToukmbb kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvdxe8wpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 16:34:28 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AFG6754009920
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 16:34:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvdxe8wns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 16:34:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+dbatAk3b87j1M3Nr5h0oEMUbYBMELk/jCis0oa0gKZP1+7xsafXj9/RhpYkpDHT2nhNQFr2nQgzkbTNCs1vNya8+uKXdNPlWY6VqAKVYTC0AXCBW/nzvW0AyvOXMUpoLm3Dvvr8kWP2WtkFaMmvm+DE6GO+Bh+CIP6M7Mib+ab9kWtemBlWH+ph6geArBKr/w0q9x/IEQFb+JLlac0AHfMKfSXTHMkCFbgJVeonXP2ORysdHoVtrV/ko0Ua+UPjtTbhtykYru9Ok+qriALwmS/Kv0kcgAoNIP2uwIYLsrGP4McExyX7bGcutQMacMcgL+mY2NkV/GxUk0o4ZYhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra3DGiqBTuxQFyoRPcoZz98RKyWOJ2Bj/axAAbqJqf4=;
 b=NNQ49gTAKVQvQ8HpvT1uWVveW3o9l6YwD5sxk8J8O+YemXzlupc2zK7ZZinoc+IKNGNzTH5pZvo8+EC3zh8U6Szv2tVJIZyNbTDziaJDfrMMKHwy2goDcB7YYM4nkJ2MSPm6UT1SdbyFrVwjkysYBsXJDc4Q/feSMjdkQz19+tDN7pZISTi3vRLMEFLMeXTmQgSKLHYX/LkvyGTBn182uKMjp9mO64lzyWkkpprHC7te+IzPk12YRArlG1zBT7+o9HfzEz2a6rc2Zxm64z5wjUnpZlo2m5dk05AoBt2unJCR/EwQnPWYWZ983CRmhZpmcLvHTGCWG/UgJ3rZq5fSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by DM6PR15MB2651.namprd15.prod.outlook.com (2603:10b6:5:1a3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 16:34:25 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::f0bd:f3a3:9b7f:d3cb]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::f0bd:f3a3:9b7f:d3cb%9]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 16:34:24 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Dan Carpenter <error27@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [bug report] RDMA/siw: Fix immediate work request flush to
 completion queue
Thread-Topic: [bug report] RDMA/siw: Fix immediate work request flush to
 completion queue
Thread-Index: AQHY+RAfe/nY5VHr2U+PX8yzUq837Q==
Date:   Tue, 15 Nov 2022 16:34:24 +0000
Message-ID: <SA0PR15MB39191C150E980BA096EA8DCE99049@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <Y3OXxkGXUFqgU/Oa@kili>
In-Reply-To: <Y3OXxkGXUFqgU/Oa@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|DM6PR15MB2651:EE_
x-ms-office365-filtering-correlation-id: fe0be404-ed94-475f-e940-08dac72741e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FL/1JBOImb6m+gilGR3cQ5drpQps9kQjd924LARmdjeg4FaGLcuYyO3XdA9w65UPmxxSjEkEJZyfPnYBv6S5ru/1SshkjUZNII4DBMpvGJmCwCHGgKOk4zGAfVY2pwlj2lw0yCaGjsjzTaRVnAijcEc4wRt5gHI5a5vKUqz8MBJAt3WB6eVy4++krtAMWpo3eDwcZoiCdSrdMjdhHYyEGNgQpFT47fpPUw0j/PUsP/xKbf4EcQGFsanERes1cAEyB+pT9drGQXMY4KMDe2b87GoZqZF91e08q773A68qSesqboBbz8t0I/trJnzUZ5xMISlcT7V7svefDa2bg7KFLEFPtwK+LOgnQR2OZCQqXvUfBQYvNqqnoA5meWoRdMwXPu80Vd+Jp00X0RO6W6R/p5khMZPWXuvtpulyCwGLs7cTyuJHq56cVK645P6QwH8E+gvRLWR/zoSNbp/1tl2mDAo1UpjIkDEs48n5/S6zwgfQCYSjtHLeldlw4j368s0YVSJv9KcQAT2vVb4xHfBPuIOYRB425eH3hUKgDH23iOQQgtjKBKW5WQb+wGsaGxNCEINMx4jzLbEs85FkyPa5RWAlJDKzDN3k8p2pqkgppSgLu02otuBQCARFC7Tj8r9EjEwJ3mDBIRXSEmLX3J3MnOfxJgqmaIA2B64joa6sm5K6ySsfOKJn/mc/H1BjojQ8JL2SfmiPLBC8V6adundGDjNJ3UDU/PQAAz1OCpH+dqlMeWF1agvDjPb8fgeDfLYKfPDoMfIMr41qq0bqX0ro4+LiHkVD9vLyy9P6Kx/IzKs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(6916009)(478600001)(7696005)(9686003)(6506007)(53546011)(33656002)(86362001)(55016003)(186003)(316002)(8936002)(38070700005)(2906002)(76116006)(66476007)(64756008)(66946007)(66556008)(66446008)(38100700002)(122000001)(71200400001)(41300700001)(5660300002)(83380400001)(52536014)(4326008)(8676002)(14773001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ris4cCtHeDV2RWg0NzZvQWxlcGdaTVV3M0dXVHNEMjVFTlAwUFFPSFdFM3VU?=
 =?utf-8?B?UmNTWjRNR21rZ2tFMDVYR0d3V1VxbDQ2bVVqei85ZXRwYytGcWowMGRUbERR?=
 =?utf-8?B?YkJCbE5INFJ4Q0JrZDZ4cXZMemtZQ3gwR2FmRWI0czI3SGtQM2h0cllnT2l5?=
 =?utf-8?B?WGJJWm40TFFLY09abUdJa1ZnVjVoMFFVMTF2UTBlN1ZBYkNIUjNFOEU1NFQr?=
 =?utf-8?B?dmxQRVA1NFUrdlZZSEtQeVBPQy9VelZYY2xRcW1BL2NodE1rekhxKzZQU21F?=
 =?utf-8?B?TTJEMUd5MmFsZ2xKS2FYR0pTU0JIRzJCcWJuMFVGNEtNanc5Z3A5Qi9IS2hQ?=
 =?utf-8?B?eUI5emsrUk95N2FzaHJsNlZMY2pTRWZOV3RTUXNMcGVpS3lvNjZ0ZlJZa2Nx?=
 =?utf-8?B?cDFvR1dkNXpCZVZVdW1aWlU0R3NHbjVDUVg3cS9sVmd3RXh1TkM0anhPU29m?=
 =?utf-8?B?c2hlMFJ2ZmNjWTlQTDVCc3BMVVhsbE80MVFXc1U5S0hEUXcrU3NLM0tRdWs3?=
 =?utf-8?B?RGVUT0FoRW9UcjBjNHloU1orSmtySzF6bkdTbzBabHBHQk9XRTdJUXJicHhD?=
 =?utf-8?B?YU9sempaelZMNTh0M0tLY0RIUWljdGpZcnhXQ3hIY2tJc1NXM0JjWlhFMmRY?=
 =?utf-8?B?L1lpUGptQUFOSTNTTzRHK1NiYzh3K1Y0dms2ci9vWjNic3BBWHAyRUpXa0x5?=
 =?utf-8?B?OFBwMEtyMjZHMGNOVUx2cHppeXlLbFZFV0pZUWlqY0YrMHBNd0Z1UGtveGpR?=
 =?utf-8?B?RUpnUE5DZTBNdFVLSERCb1Mxd0tYd3lWOFU1aGdTR294Z2NZa1hqakpUK0ls?=
 =?utf-8?B?S2RBSkl0MlV2UHNkak1PZ3dsc0xsWFBqUXh4c1dudFdvWU1leFlSZlhpU0hr?=
 =?utf-8?B?SU9VUldzT1Z2UEpCb1l4Q2o5Q0FRbGFzOGVWWEFGVjFQZ2RrMHIyZ2QvVlI2?=
 =?utf-8?B?OFpHb3RxV2lyK21JenUwWVZpcHVxa25KZFkvK2M5UVVVTlBNbXRIZnZ3UnYv?=
 =?utf-8?B?cGpDUWREQkNkaEZ6UEsvNzVpdHBxZlJZY2dTYW1zMGFCNVRxcnZYUXMrZDFn?=
 =?utf-8?B?TFV6N2xveDhEelBGdHNrU05rZDVndzRGTThRS25xKy9lZDE5SmRONGkwdXJ6?=
 =?utf-8?B?ZThVd1U2am1GVm9OY2o5NGhoM1BacUYxZTltbzZVY0FIUmIrajVacWVnS0hq?=
 =?utf-8?B?QTVHN3VQdFN2UTBPczJTb3ptbG9WZzVSV0JoNWViMWVld1RtU2sxTFF1eTVZ?=
 =?utf-8?B?N2JoYVFOeHlNZUppN1dSS1NpbytaRVBGMjlCS3pPMjltZlpxZkFNdml1cGhD?=
 =?utf-8?B?S0lUN2xyUzlWZjEyTThLNGtiVWhxdVBWWVYrY3BXSmhxb2grd0RPeUtpVk1H?=
 =?utf-8?B?K0xxeUFvUnhvbWFMNmJrMGd4UHV1S3M3MFd1R3Vzc0t4NTQ0RFo5OWVMT2hr?=
 =?utf-8?B?S3EvOGRQNklRMXdSUGpXV0tybEI0TVRJV3k5R3Z2MWk1NGhpbDFzbHZKTmpI?=
 =?utf-8?B?SDBSMFhCdFRQQjh4NEdMeFJCb1hqVmlYWS9HMGo1WU5ZQ2ZBTHQ5L25LTjJG?=
 =?utf-8?B?ZmdoSW42Q0R1MjNERWpLdHdGLzE2WXR3cExGNGs5TTVRVzgwMENhSmEwL3Ru?=
 =?utf-8?B?UTJyb1dSV0VRdHlQQm45MlBTNkhybjRmSk83QkppV2tkdy9MV0h3aWZVMENG?=
 =?utf-8?B?cm5TaHlEMURaUmdiSVNFVW5ZNmkwMWdxeTBTVzlZLzRUbS9UbGRmdm0wTXlR?=
 =?utf-8?B?TXZudGd1N0lINFNwSmhjcXFWeTBWYWg2Z1pJZ0RQMlRiVnBnSGZpSDdvZ29z?=
 =?utf-8?B?TVhldnRTVWM0dW03b1BCVkJFTkR5THJzditDT0tmTnlBUXRpOXZvSWZ3OTFH?=
 =?utf-8?B?OWFsU3Nudy9XUTVWdXRiT3dEVzFQaGJ1WjdkdmtOcUErOGozZGUxZ0Y0Q2RW?=
 =?utf-8?B?bTI3emdnZFdySFgyYko3clZOV2Y3eThkUktzSGM2b0M2US9sc2Jnd0x1YVY3?=
 =?utf-8?B?cWJ4czF1Nlp2MzM1M1Q2NUt4VStxU25uL3BmVzhuK2c2TjJhWmdoUG8yM3dO?=
 =?utf-8?B?L25QcU16Tm4xK0ZTSnhaeG5rMmlCRkpmRVhEaVhqT1h6ZUVtTTR3OWNXcTlX?=
 =?utf-8?B?WTJRZVpCYVVpVG05aEsycUpEeTBkclovRGJTL0VzWU1GWHhYWk5IYnB0SFJm?=
 =?utf-8?Q?3ur+EMv1LYlZ2fQHDhHHMCZlNMeKNIdtVkag/RDBvBz6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0be404-ed94-475f-e940-08dac72741e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 16:34:24.9297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNbfxKwKjwIJrmpWuNuvS6gyjG/j8N6hHFxClwBrI/pRouOjhyscz81zS+SicbR2D4iPTMW3TSVrMCYTR5FAEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2651
X-Proofpoint-GUID: QGQs1nJicLpYvtSbLZGX6TqNGztpAzrr
X-Proofpoint-ORIG-GUID: -VChtiZQVR3OZSoNaUZtzJ3zzUUEb8kA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIENhcnBlbnRlciA8
ZXJyb3IyN0BnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDE1IE5vdmVtYmVyIDIwMjIgMTQ6
NDUNCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzogbGlu
dXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBbYnVnIHJlcG9y
dF0gUkRNQS9zaXc6IEZpeCBpbW1lZGlhdGUgd29yayByZXF1ZXN0IGZsdXNoDQo+IHRvIGNvbXBs
ZXRpb24gcXVldWUNCj4gDQo+IEhlbGxvIEJlcm5hcmQgTWV0emxlciwNCj4gDQo+IFRoZSBwYXRj
aCBiZGYxZGE1ZGY5ZGE6ICJSRE1BL3NpdzogRml4IGltbWVkaWF0ZSB3b3JrIHJlcXVlc3QgZmx1
c2gNCj4gdG8gY29tcGxldGlvbiBxdWV1ZSIgZnJvbSBOb3YgNywgMjAyMiwgbGVhZHMgdG8gdGhl
IGZvbGxvd2luZyBTbWF0Y2gNCj4gc3RhdGljIGNoZWNrZXIgd2FybmluZzoNCg0KSGkgRGFuIENh
cnBlbnRlciwNCg0KdGhhdOKAmXMgYSBmYW50YXN0aWMgdG9vbCEgSSBzaGFsbCBtYWtlIHVzZSBv
ZiBpdA0KdG8gY2F0Y2ggdGhvc2UgYmFkIHR5cG9zLg0KDQpJdCBzaG91bGQgaGF2ZSBiZWVuIFNJ
V19XQ19HRU5FUkFMX0VSUg0KaW5zdGVhZCBvZiBJQl9XQ19HRU5FUkFMX0VSUg0KDQpJJ2xsIHNl
bmQgYSBmaXggYXNhcC4NCg0KVGhhbmtzIHZlcnkgbXVjaCENCg0KQmVybmFyZC4NCj4gDQo+IAlk
cml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jcS5jOjk2IHNpd19yZWFwX2NxZSgpDQo+IAll
cnJvcjogYnVmZmVyIG92ZXJmbG93ICdtYXBfY3FlX3N0YXR1cycgMTAgPD0gMjENCj4gDQo+IGRy
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NxLmMNCj4gICAgIDQ4IGludCBzaXdfcmVhcF9j
cWUoc3RydWN0IHNpd19jcSAqY3EsIHN0cnVjdCBpYl93YyAqd2MpDQo+ICAgICA0OSB7DQo+ICAg
ICA1MCAgICAgICAgIHN0cnVjdCBzaXdfY3FlICpjcWU7DQo+ICAgICA1MSAgICAgICAgIHVuc2ln
bmVkIGxvbmcgZmxhZ3M7DQo+ICAgICA1Mg0KPiAgICAgNTMgICAgICAgICBzcGluX2xvY2tfaXJx
c2F2ZSgmY3EtPmxvY2ssIGZsYWdzKTsNCj4gICAgIDU0DQo+ICAgICA1NSAgICAgICAgIGNxZSA9
ICZjcS0+cXVldWVbY3EtPmNxX2dldCAlIGNxLT5udW1fY3FlXTsNCj4gICAgIDU2ICAgICAgICAg
aWYgKFJFQURfT05DRShjcWUtPmZsYWdzKSAmIFNJV19XUUVfVkFMSUQpIHsNCj4gICAgIDU3ICAg
ICAgICAgICAgICAgICBtZW1zZXQod2MsIDAsIHNpemVvZigqd2MpKTsNCj4gICAgIDU4ICAgICAg
ICAgICAgICAgICB3Yy0+d3JfaWQgPSBjcWUtPmlkOw0KPiAgICAgNTkgICAgICAgICAgICAgICAg
IHdjLT5ieXRlX2xlbiA9IGNxZS0+Ynl0ZXM7DQo+ICAgICA2MA0KPiAgICAgNjEgICAgICAgICAg
ICAgICAgIC8qDQo+ICAgICA2MiAgICAgICAgICAgICAgICAgICogRHVyaW5nIENRIGZsdXNoLCBh
bHNvIHVzZXIgbGFuZCBDUUUncyBtYXkgZ2V0DQo+ICAgICA2MyAgICAgICAgICAgICAgICAgICog
cmVhcGVkIGhlcmUsIHdoaWNoIGRvIG5vdCBob2xkIGEgUVAgcmVmZXJlbmNlDQo+ICAgICA2NCAg
ICAgICAgICAgICAgICAgICogYW5kIGRvIG5vdCBxdWFsaWZ5IGZvciBtZW1vcnkgZXh0ZW5zaW9u
IHZlcmJzLg0KPiAgICAgNjUgICAgICAgICAgICAgICAgICAqLw0KPiAgICAgNjYgICAgICAgICAg
ICAgICAgIGlmIChsaWtlbHkocmRtYV9pc19rZXJuZWxfcmVzKCZjcS0+YmFzZV9jcS5yZXMpKSkg
ew0KPiAgICAgNjcgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGNxZS0+ZmxhZ3MgJiBTSVdf
V1FFX1JFTV9JTlZBTCkgew0KPiAgICAgNjggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB3Yy0+ZXguaW52YWxpZGF0ZV9ya2V5ID0gY3FlLQ0KPiA+aW52YWxfc3RhZzsNCj4gICAgIDY5
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd2MtPndjX2ZsYWdzID0NCj4gSUJfV0Nf
V0lUSF9JTlZBTElEQVRFOw0KPiAgICAgNzAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiAg
ICAgNzEgICAgICAgICAgICAgICAgICAgICAgICAgd2MtPnFwID0gY3FlLT5iYXNlX3FwOw0KPiAg
ICAgNzIgICAgICAgICAgICAgICAgICAgICAgICAgd2MtPm9wY29kZSA9IG1hcF93Y19vcGNvZGVb
Y3FlLT5vcGNvZGVdOw0KPiAgICAgNzMgICAgICAgICAgICAgICAgICAgICAgICAgd2MtPnN0YXR1
cyA9IG1hcF9jcWVfc3RhdHVzW2NxZS0+c3RhdHVzXS5pYjsNCj4gICAgIDc0ICAgICAgICAgICAg
ICAgICAgICAgICAgIHNpd19kYmdfY3EoY3EsDQo+ICAgICA3NSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICJpZHggJXUsIHR5cGUgJWQsIGZsYWdzICUyeCwgaWQNCj4gMHglcEtc
biIsDQo+ICAgICA3NiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNxLT5jcV9n
ZXQgJSBjcS0+bnVtX2NxZSwgY3FlLQ0KPiA+b3Bjb2RlLA0KPiAgICAgNzcgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjcWUtPmZsYWdzLCAodm9pZA0KPiAqKSh1aW50cHRyX3Qp
Y3FlLT5pZCk7DQo+ICAgICA3OCAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gICAgIDc5ICAg
ICAgICAgICAgICAgICAgICAgICAgIC8qDQo+ICAgICA4MCAgICAgICAgICAgICAgICAgICAgICAg
ICAgKiBBIG1hbGljaW91cyB1c2VyIG1heSBzZXQgaW52YWxpZCBvcGNvZGUNCj4gb3INCj4gICAg
IDgxICAgICAgICAgICAgICAgICAgICAgICAgICAqIHN0YXR1cyBpbiB0aGUgdXNlciBtbWFwcGVk
IENRRSBhcnJheS4NCj4gICAgIDgyICAgICAgICAgICAgICAgICAgICAgICAgICAqIFNhbml0eSBj
aGVjayBhbmQgY29ycmVjdCB2YWx1ZXMgaW4gdGhhdA0KPiBjYXNlDQo+ICAgICA4MyAgICAgICAg
ICAgICAgICAgICAgICAgICAgKiB0byBhdm9pZCBvdXQtb2YtYm91bmRzIGFjY2VzcyB0byBnbG9i
YWwNCj4gYXJyYXlzDQo+ICAgICA4NCAgICAgICAgICAgICAgICAgICAgICAgICAgKiBmb3Igb3Bj
b2RlIGFuZCBzdGF0dXMgbWFwcGluZy4NCj4gICAgIDg1ICAgICAgICAgICAgICAgICAgICAgICAg
ICAqLw0KPiAgICAgODYgICAgICAgICAgICAgICAgICAgICAgICAgdTggb3Bjb2RlID0gY3FlLT5v
cGNvZGU7DQo+ICAgICA4NyAgICAgICAgICAgICAgICAgICAgICAgICB1MTYgc3RhdHVzID0gY3Fl
LT5zdGF0dXM7DQo+ICAgICA4OA0KPiAgICAgODkgICAgICAgICAgICAgICAgICAgICAgICAgaWYg
KG9wY29kZSA+PSBTSVdfTlVNX09QQ09ERVMpIHsNCj4gICAgIDkwICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgb3Bjb2RlID0gMDsNCj4gICAgIDkxICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RhdHVzID0gSUJfV0NfR0VORVJBTF9FUlI7DQo+IA0KPiBJQl9XQ19HRU5F
UkFMX0VSUiBpcyAyMS4NCj4gDQo+ICAgICA5MiAgICAgICAgICAgICAgICAgICAgICAgICB9IGVs
c2UgaWYgKHN0YXR1cyA+PSBTSVdfTlVNX1dDX1NUQVRVUykgew0KPiAgICAgOTMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSBJQl9XQ19HRU5FUkFMX0VSUjsNCj4gDQo+
IEhlcmUgdG9vLg0KPiANCj4gICAgIDk0ICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAg
IDk1ICAgICAgICAgICAgICAgICAgICAgICAgIHdjLT5vcGNvZGUgPSBtYXBfd2Nfb3Bjb2RlW29w
Y29kZV07DQo+IC0tPiA5NiAgICAgICAgICAgICAgICAgICAgICAgICB3Yy0+c3RhdHVzID0gbWFw
X2NxZV9zdGF0dXNbc3RhdHVzXS5pYjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl4NCj4gT3V0IG9mIGJvdW5kcy4NCj4gDQo+ICAg
ICA5Nw0KPiAgICAgOTggICAgICAgICAgICAgICAgIH0NCj4gICAgIDk5ICAgICAgICAgICAgICAg
ICBXUklURV9PTkNFKGNxZS0+ZmxhZ3MsIDApOw0KPiAgICAgMTAwICAgICAgICAgICAgICAgICBj
cS0+Y3FfZ2V0Kys7DQo+ICAgICAxMDENCj4gICAgIDEwMiAgICAgICAgICAgICAgICAgc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmY3EtPmxvY2ssIGZsYWdzKTsNCj4gICAgIDEwMw0KPiAgICAgMTA0
ICAgICAgICAgICAgICAgICByZXR1cm4gMTsNCj4gICAgIDEwNSAgICAgICAgIH0NCj4gICAgIDEw
NiAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNxLT5sb2NrLCBmbGFncyk7DQo+ICAg
ICAxMDcNCj4gICAgIDEwOCAgICAgICAgIHJldHVybiAwOw0KPiAgICAgMTA5IH0NCj4gDQo+IHJl
Z2FyZHMsDQo+IGRhbiBjYXJwZW50ZXINCg==
