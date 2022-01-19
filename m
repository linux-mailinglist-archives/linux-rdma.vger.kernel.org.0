Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3332849380D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 11:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353528AbiASKQE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 05:16:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353525AbiASKP7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jan 2022 05:15:59 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JA41mG016780;
        Wed, 19 Jan 2022 10:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=Y0hjtLwsXa2q98W7Wa0G01+Qia8ckfKm3JAi6wPwaYE=;
 b=NNzLDNgzvPfPfa+uUg/jL7fRg0/5yezsM+uQZX8ygUHwl7GFzgrENnNeTWtSjCscMSgG
 O7+d6+q/ze5TLCZJtApIQdxIwvygbixO8GRSI9sgkxlyRNwnZ3CNy8ECpVhmLLQgtwfS
 rzvvieGpWdGvQ5UvVsY3aOBR7eUTui3qMsYiEhir+8jO/xJ9dj4+kiIROYg8N4L9B9Zg
 qvZMkZ358/ddnSq/qaRso4i9ILXS3shjKSRFWVd2EIW52ORTAf0mxDCE8nsCKUSIF2kX
 am+VVU2IrtbvLN+8Q4W1OrH07F6odWEhNailDRo5+xEVo5x/FK1F5p1JnYl921ZyAYEp Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dpgjjg5tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 10:15:55 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20JA4b7t017799;
        Wed, 19 Jan 2022 10:15:55 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dpgjjg5tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 10:15:55 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20JADUDP027738;
        Wed, 19 Jan 2022 10:15:54 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3dknwcnu29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 10:15:54 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20JAFrMg25035124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 10:15:53 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2503FC6061;
        Wed, 19 Jan 2022 10:15:53 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6C79C6055;
        Wed, 19 Jan 2022 10:15:52 +0000 (GMT)
Received: from mail.gmx.ibm.com (unknown [9.209.242.114])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Jan 2022 10:15:52 +0000 (GMT)
Received: from m01ex004.gmx.ibm.com (10.148.53.60) by m01ex002.gmx.ibm.com
 (10.148.53.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 19 Jan
 2022 05:15:45 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (9.221.46.12) by
 m01ex004.gmx.ibm.com (10.148.53.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 19 Jan 2022 05:15:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcR9ekh7S5RtxixU2TRa6TUY89yX8Kc2Jk40Ui9yFC3pgqwgJ4vy1Unc8gpVBe43SI89nppXaiw5MLx4Twid2+v36yhIki6iDWI9hBuSRSTe5KFxcZrtT9T2uF4ou/PxnncNbR5XBJUESItQ2Dm2V/h+zRoEYIqVld+YxX1nXnlEOebEx/YuGh1VOxWS3UuyRIBEAPJPowvo4HeyRdgS14C7nT65igjI9LwhSBp2/rcHnI7tl4sxrQaAOOwOAmcJpHAOvqSjoG2izLJckdk7qXKoEavQyrpF5zOxiKg8no4CISI+dtOdX5NowDBbOUu8df2wACCSFkyTe1Xc2dlCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0hjtLwsXa2q98W7Wa0G01+Qia8ckfKm3JAi6wPwaYE=;
 b=ZWav9y5+GkQ09empCN+/7KXDlUh+lGU2RJuOkzoHgmuHEGg3TsKqKWwK6xVLRKgjz5Sspf3u84nKUa43ATxhaJ78APLpN5GeGKCRo+Zk8otKFNOGu5bhIf15Tv+Nx1WcT4+a8PY+FLVMQhRPg9PvsfEKzucAbzRo6+mInXuLqfwEyVWuoA4C4W/pkXZ+2+aW6fWs4D/o+TxSY4GvF6QKvtZpVIihndpM/USt7roapDFV90h+fkAxUZTaovhVGxEkLTLrpw8HI9BHPuPVGfvVXN8hF4x1RtIFUBcAUZe6qhr6hP89f26o7Hvd7lJ57SdjJabSU+v6vX09E0jV5ENMnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by MWHPR15MB1215.namprd15.prod.outlook.com (2603:10b6:320:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 10:15:43 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::31b8:a1ab:2121:fba3]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::31b8:a1ab:2121:fba3%6]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 10:15:43 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
Subject: RE: Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the erdma module
Thread-Topic: Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the erdma module
Thread-Index: AdgNHXz7WTIxuHexQuCN8XoEiKQxyw==
Date:   Wed, 19 Jan 2022 10:15:43 +0000
Message-ID: <BYAPR15MB263126902D1FC48911A42BD999599@BYAPR15MB2631.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f489632-5405-45fa-cc39-08d9db34a6d4
x-ms-traffictypediagnostic: MWHPR15MB1215:EE_
x-microsoft-antispam-prvs: <MWHPR15MB1215ABA51CD6F145045F24C499599@MWHPR15MB1215.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NLXINWkw4xf5VoN8bhV9cElTmzL2o9a1rJplIgMLShp3mXYQjrGvcacx27PnNSMBL6LSI7l82JdBJFoq9FIAl/u05yACBT7AffyqR/iTwgdR1zIQG7Fx2WPPrnM4q9mMD2c/8Ij3813Rvd4m44pkdSiGmuXVUSWtAnk74wtr6+JseLdyxjaWD36D4o0kqjLPY6qvQ0n6u3XNaOf9MUxFnWPtsgPJgdXT5dry2lJNAnoRc7TWc+am6FHXc0pIkCSEMXhnr63WAABSefIFTNy9Ge6U9h+mnCsahrrNN78oxILnFodsrq643YXVQjMjmQ4ZX1FGd/yPb3On8rCN2xilLQn2IAPX64RvoHjJq2hf6VtZ5o9XaVYOy/y0mngQQpDHSznYCLP961uSUfdj3KbQTiDV8gIZNiPlcPrjQq7V1VFlu3eLF39jTSlImPmW0r6+Sm1wAdg5IEYB3Wr862C4sSEWXGxJQgjM1BV3m0m7VPlydVT0igRD5FJAT6MxwLs6X7g7u9qJ0h1V4HNUWM5QGnNz+S0p30P+abX7wMQS7wxTbFSIsBaBXFnuYZadUuSqeNg6i8Jd1FYVcrVeK6NVvKlZJ3/aGMRQhlktsfAXto2HFfTLavERwh5jcebzwynk3WIuBuqhFs8U8YjB4Vx4NcSaTnlNbozODdCIsae6omNuNQ+7Q6SnhMusBbPxqwhdaY83EQFF0CdeKgj/cOm9Tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(38100700002)(4326008)(8676002)(508600001)(53546011)(64756008)(66556008)(5660300002)(7696005)(71200400001)(2906002)(6506007)(38070700005)(122000001)(76116006)(54906003)(66446008)(66476007)(8936002)(9686003)(52536014)(55016003)(86362001)(316002)(83380400001)(66946007)(186003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXNMTFk1S1FBbWJwN241YjIxbHRUYnF0U0pXVkg2cnVWRGV6OWo5SHNqeUpw?=
 =?utf-8?B?TThiL2tEWjdVcGlqUGF4T0dOYUNxNVJVVU1LenhmY1Z4SW5WSVppYWpjNElB?=
 =?utf-8?B?RmFjbWs4NHZlS3A1MzdpUnhJd2lMVW5pTUFkazlqbmN6UGRuZUdvaVNxSGt3?=
 =?utf-8?B?U21YZUd5U2IvMjhLcDdhYmc2MXdOQTFINkloQys3WGllbjJNTVdkMjlyU3NO?=
 =?utf-8?B?MjI3V29jMHo5VjhUSGxPbXdlcEMwRzV5L085Ym9zeWdpZDBzYk5FcjZVZG5j?=
 =?utf-8?B?VzFlYzBVN3J5a3FJUTNOV3JMY0ozaTRBendCdEF4dkljNWVFUWlDZUxhb3ll?=
 =?utf-8?B?SEkranE3L01JdldieU1qaDdpYlNjVGZDQTA3b1puUEpXc1pndmc0dml6ZFRl?=
 =?utf-8?B?ZjBEcXpPNXFtZXprRWxQUmtIb2lFcWVhMG0rVVkrYnBreTlqNWZQZ2VnVWZs?=
 =?utf-8?B?UWVsSWxHaXVnLzlXYU53bkJOTVIyZDZtUmM4QjB3dkdQTUlGYUkyUDRNa2cr?=
 =?utf-8?B?aXlRdkZEUEhtUDJOb3pvKzlaSW1CZkVlRk1HdGRmUkp0b0Y4aUp1WjlZckIx?=
 =?utf-8?B?OXorYWtRdW5VclRCSHFJMVhVb0tXU05idTdZN21CLzNTNVl3eENPVER5MUxa?=
 =?utf-8?B?RmZrY0lKOEIrQnFObVRIdmVQQnd3Z01qTE9qdWNDclBPVVBDNXFXUzRwakZh?=
 =?utf-8?B?WE9ydTFTNVAzTDBITjh0SGF1ZTVtNWhycmpnNGlmTDZpdTVxUGNRdDNIYy9J?=
 =?utf-8?B?Qk1XUjUwUmg4R0lPQU96WHlua1MrTTlkREI4bjdLVVpuMHRoYitKbXFwbm40?=
 =?utf-8?B?R1JlWWdOeklrbTEyWE1qYlBaUkxLOENPY283U292K1diNVlKTDhsNnc1VHo3?=
 =?utf-8?B?WFJhSFRsdU10V24yYlV1VWtmd29GUmxqWTRKcys5SERvMUt4M2xhN2tEdTZw?=
 =?utf-8?B?bUhSZmd1aHVxVE4ycDFwU1BvcjdJQkN4R1dVMDFaY3dvcWYwQ0xLekp4UkFr?=
 =?utf-8?B?MGZBSkpvM1pmRnFTOVpHVDdya2xTUVZCNG9Uc1hnMnJLby9EcWFZUWd6alIw?=
 =?utf-8?B?VTdRQjRCbUp3ZnhiTHhodXI2bDNvbGxkRk8wOGExbFFyeWRaSDIwUE92d28z?=
 =?utf-8?B?TWU0TlJtTXhObXFEdWFDWkJuclJKWEwvZGZISjFIeTlybm1kNnBycGRlRm1o?=
 =?utf-8?B?cTA3N3pDci9ITFU4Y0JWSEFLUkVsSk9TOE9yMTNaZW1JeUI0WVR3dXgxL0l6?=
 =?utf-8?B?OW5sOHhkM0VGRnpaU1VCbDV0WlR5alNLNDZFVEVLUi9NQ2xQS3g3OW54SENW?=
 =?utf-8?B?VlhGeDlBNUpBQ1owL2QwT29yVUJPRHVWZEs5Y3NRNDl4UERpTG5MRUFHcmFE?=
 =?utf-8?B?My9kampvam9aYk52NFp4Nk5GS3UxOWhBaGYxckxoVEhyaGZCSEZid3RicVZy?=
 =?utf-8?B?cXYvZ2U0VHVJY1dRa1ZFV3R0OEZKRWRRc1FXRklhbzdOd0FwQzNiMDNDU1kz?=
 =?utf-8?B?MStHNTJHbStzTFB4ZSsvc0FEOHBTdERsZE9kcWx3blg2cGVadHVycG5HZjZI?=
 =?utf-8?B?NDNBUnVFOW9qSDJqeUEzN2FvMnNmR2RvbUwzQmI0REdpVldGU3VlZDV4blNh?=
 =?utf-8?B?WUJlRzRUZDdBcVpJcmlRY2dyZ3NOUnFpWWhhSDFWQmlFK0ZwbnREOThmT2NQ?=
 =?utf-8?B?UTV2TDFCejlOSHJUR2pUWFhDenVUT2NrYXI2NU92eERlYVJvcCtsYnB1Ymlk?=
 =?utf-8?B?YVBkNWRRMnJpWVBhNmFoR0FyMUJaeVhxQ3BSb3cyeENkMVJEV2hvbHJJMnVr?=
 =?utf-8?B?WGp6dlJkemJLYUhacjVqTFo1elVVMXR6MlZxQktiYTltSTM2NWtISGd4aW1p?=
 =?utf-8?B?aExDV3lZYTFzMFI2UmhLNXpCNFN4bi9SbjUvWE5zTmthZFNzN29mTHkwWVBn?=
 =?utf-8?B?cFU4dWhZYkl4YUpKUDdsRVlzUDFWZC9iOGh3eFhjSjZRRm5LZzZWeFJac09U?=
 =?utf-8?B?NlkreWFVVXFNNzNveWNTMVcxRFJBa2k4VTNOOHhUank0ekNjMTBYU3RpWFpC?=
 =?utf-8?B?SjEvZ0kwVjdmR1dIdVVNYkRZSlI0Y3E4L1RzUWtPT0NuZHVQYXlqZGt2bksz?=
 =?utf-8?B?ajAwbGtsMEpYRE1uRDNLOTQyZ3F6dGZQTXUzT09uMkNXMTRNUENySUl1SE1P?=
 =?utf-8?B?Q3BPc3lTK25nbnlab1VycWdoMkFDSlFEQlVxcXArNGxpeEgxRVVLOVZqQWFI?=
 =?utf-8?Q?h6Bc9k+CYI/s8jBIqNAu7+EfFr2RUFNgAvZecGWP2s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f489632-5405-45fa-cc39-08d9db34a6d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 10:15:43.2444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2Jsvx1rzBkwp6A64Aj9TT8wrQkEySEMmf9/BW+NP3kEPNvX/GO+RBCyoFennui1spzI1n+uvRiVIYmarcoYmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1215
X-OriginatorOrg: Zurich.ibm.com
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3FEkVlVdhDlHv98Ercyi1QiVQ6Ootwl9
X-Proofpoint-ORIG-GUID: fO114GFMkYZid345nkXk8Oct3C51XKkH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_06,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190055
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hlbmcgWHUgPGNoZW5n
eW91QGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDE5IEphbnVhcnkgMjAy
MiAwNToxOQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBqZ2dA
emllcGUuY2E7DQo+IGRsZWRmb3JkQHJlZGhhdC5jb20NCj4gQ2M6IGxlb25Aa2VybmVsLm9yZzsg
bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IEthaVNoZW5AbGludXguYWxpYmFiYS5jb207
IHRvbnlsdUBsaW51eC5hbGliYWJhLmNvbQ0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFU
Q0ggcmRtYS1uZXh0IHYyIDA5LzExXSBSRE1BL2VyZG1hOiBBZGQgdGhlDQo+IGVyZG1hIG1vZHVs
ZQ0KPiANCj4gDQo+IA0KPiBPbiAxLzE4LzIyIDg6NTMgUE0sIEJlcm5hcmQgTWV0emxlciB3cm90
ZToNCj4gDQo+IDwuLi4+DQo+IA0KPiA+PiArc3RhdGljIGludCBlcmRtYV9yZXNfY2JfaW5pdChz
dHJ1Y3QgZXJkbWFfZGV2ICpkZXYpDQo+ID4+ICt7DQo+ID4+ICsJaW50IGk7DQo+ID4+ICsNCj4g
Pj4gKwlmb3IgKGkgPSAwOyBpIDwgRVJETUFfUkVTX0NOVDsgaSsrKSB7DQo+ID4+ICsJCWRldi0+
cmVzX2NiW2ldLm5leHRfYWxsb2NfaWR4ID0gMTsNCj4gPj4gKwkJc3Bpbl9sb2NrX2luaXQoJmRl
di0+cmVzX2NiW2ldLmxvY2spOw0KPiA+PiArCQlkZXYtPnJlc19jYltpXS5iaXRtYXAgPSBrY2Fs
bG9jKEJJVFNfVE9fTE9OR1MoZGV2LQ0KPiA+Pj4gcmVzX2NiW2ldLm1heF9jYXApLA0KPiA+PiAr
CQkJCQkJc2l6ZW9mKHVuc2lnbmVkIGxvbmcpLCBHRlBfS0VSTkVMKTsNCj4gPg0KPiA+IGJldHRl
ciBzdGF5IHdpdGggbGVzcyB0aGFuIDgwIGNoYXJzIHBlciBsaW5lDQo+ID4gdGhyb3VnaG91dCB0
aGUgcGF0Y2ggc2VyaWVzIChJIGNvdW50IGN1cnJlbnRseSAyODcgbGluZSB3cmFwcykuDQo+ID4N
Cj4gDQo+IFRoZSBrZXJuZWwgbm93IGFsbG93cyAxMDAgY2hhcnMgcGVyIGxpbmUsIGFuZCB0aGUg
Y2hlY2twYXRoLnBsIGFsc28NCj4gY2hlY2tzIHVzaW5nIHRoZSBuZXcgcnVsZSBub3cuIEkgd2ls
bCB0cnkgdG8gY2hhbmdlIHRoaXMgdG8gODAgY2hhcnMsDQo+IGJ1dCBpdCBhY3R1YWxseSBtYWtl
cyBzb21lIGNvZGUgbm90IGZyaWVuZGx5IGZvciByZWFkaW5nIGR1ZSB0bw0KPiBpbmRlbnQuDQo+
IA0KDQpEbyB3ZSBoYXZlIGEgcmVjb21tZW5kYXRpb24vYWdyZWVtZW50IHRvIHN0YXkgd2l0aCA4
MCBjaGFycyBwZXIgbGluZQ0KZm9yIHRoZSBSRE1BIHN1YnN5c3RlbT8gSSdkIGxpa2UgaXQsIGJ1
dCBJIGFtIG5vdCBzdXJlLg0KDQo+IDwuLi4+DQo+IA0KDQpUaGFua3MsDQpCZXJuYXJkLg0KDQo=
