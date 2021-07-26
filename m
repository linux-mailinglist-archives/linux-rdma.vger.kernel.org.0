Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C1E3D5A27
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jul 2021 15:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhGZMfa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 08:35:30 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:37622 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233362AbhGZMf3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Jul 2021 08:35:29 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QDDEks029069;
        Mon, 26 Jul 2021 13:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=18QsPQIjFrLWSaKm3E7K+Zv4jzTvD4v1zsforFlpuLs=;
 b=JnV37rZpL3rJRjiBp4K8QRI0FdZNPhxfVmoFxqSXaAiiHNTmz2Npun7snJiUevm732mf
 g8H9eeW6fsnZovVqd/snZrfg5mdjbUykd+v4ADlUxFzkjoQ6TSfRj9Pika2W833PfNhw
 BDmgQburZnuhamNdtGSG+dSo2D/X4bRDWUad3jDazcbJP3XD4cv7Fjm+745VhilAl8mh
 fclyAFxahMz/oZELM/9gzjWQuhLnLcJy1dXAWUvCdmyWO/1W2nZ1/xm/zSE9HWgJYhPS
 3m5wFHmVXI/KViN9Y7/EHQv+j4cOlgp5UaqG1gCzJ9pvTkw9LvFpuXSIexLlfCCrBbTJ OQ== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0a-002e3701.pphosted.com with ESMTP id 3a1w4sgcmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 13:15:51 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id 1C53E9E;
        Mon, 26 Jul 2021 13:15:51 +0000 (UTC)
Received: from G4W9336.americas.hpqcorp.net (16.208.33.86) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Mon, 26 Jul 2021 13:15:46 +0000
Received: from G4W10204.americas.hpqcorp.net (2002:10cf:5210::10cf:5210) by
 G4W9336.americas.hpqcorp.net (2002:10d0:2156::10d0:2156) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Mon, 26 Jul 2021 13:15:45 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (15.241.52.10) by
 G4W10204.americas.hpqcorp.net (16.207.82.16) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18 via Frontend Transport; Mon, 26 Jul 2021 13:15:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTvimRZJhWjoaLA6+iEiLJJEmQ0MeZUVi19pDve6h7TE8D9kHHmIJtJIdyR+rFe5zMXf4XtL3KLaiH8Cv8SH/2Xf6twotm6Iva8mrNc8q/boGU99USD+36FNhJNu7AUc2sj98Q33VeqkuPQAhc7oToNDddq1+K86exelgbJgkgBCuafCPr95gT1xcq7RnnHF2XOaXON2A6OX7yZQxpPyceRIYEhRYLPB+CH6rmpMuLI8f2pZgKq2B86EFjmpCjVFGOA+dWwwOqk+guQJn3YPfhy/n6UPEQoOPBcmovUGptt1U23IoOOzrqcihiHIOWROVdP/Jj8kEp5SwKEkgvmhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18QsPQIjFrLWSaKm3E7K+Zv4jzTvD4v1zsforFlpuLs=;
 b=b2+Ctk2z6m7oAarBqPgi732nqlYloVLCK75k9GImd4NH7P/DQn4mq84GCLPNTxPv+gbFmcKNB3yjcgGf7+b271A6SPfFc5bifI2ZaZRYwLEsh1x3rpwYPaU3w/zc9FZbC4jIrRz2MXclf8f8mv2Xh17VvyweXzjclHtebMIzfwGn4XOfIKmXbVkgwtim61SQ0GMzn/TkgxMUusHcNg5zJhtoO7KTlZihYz6SE9jnJJHllx3dWtyEMkV8EjKXlQiagZXm6M6W7qtHUyjejaRThnHDuSFhRW4fVM+AlfkFSSQeWGgZrupiqo64CiCLEesLb6mhPvRDIGFX8KO2GwjrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7511::15) by CS1PR8401MB0791.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 13:15:44 +0000
Received: from CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1eb:4099:95a3:7c99]) by CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1eb:4099:95a3:7c99%10]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 13:15:44 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Olga Kornievskaia <aglo@umich.edu>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] RDMA/rxe: Fix bug in rxe_net.c
Thread-Topic: [PATCH for-next] RDMA/rxe: Fix bug in rxe_net.c
Thread-Index: AQHXfnlAWNApHhtR90SEth7kUMlPZqtOJNuAgAAW/nCAAOYsgIAFxKGAgABcKnA=
Date:   Mon, 26 Jul 2021 13:15:44 +0000
Message-ID: <CS1PR8401MB10770B5F89BC27F34836E70CBCE89@CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210721214105.8099-1-rpearsonhpe@gmail.com>
 <CAN-5tyEkkBN49HCghKSCfPb8e_+0C2PCt8o51TOaMBS=3L7AuA@mail.gmail.com>
 <CS1PR8401MB10968C0943041FEDCBEBF8BDBCE49@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
 <CAN-5tyEVZRUyFf4bGRvL-DkoMmAXB10zQhZFB7K_UzNJ2uNWVQ@mail.gmail.com>
 <CAD=hENdqHx7FANVNFG4u-_WFmgsMBa=Mv67V3emqcO+wgwZaCQ@mail.gmail.com>
In-Reply-To: <CAD=hENdqHx7FANVNFG4u-_WFmgsMBa=Mv67V3emqcO+wgwZaCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hpe.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca8c63b4-286a-4cb7-c562-08d95037798b
x-ms-traffictypediagnostic: CS1PR8401MB0791:
x-microsoft-antispam-prvs: <CS1PR8401MB079118FDC35461D685F39377BCE89@CS1PR8401MB0791.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M0HLQpFLTrCzYcDRVil/7GWLouOwnm1GRjtVSxJX7xgdOeZgSOL4qCsst8sLjEvTup9CkI52U+qLmJ9/MPowzaqNv+XWV+ujwq3w3BDbvcmGbqmNRhWVGME4yW10lWz3yWhmBUbXoEob2gXSbpShUiCMsIVx48zWcwG5bLYUUqWv6QXbA29nIPM65PJmfyYPnpyksNBl83/Koq8yd8gI9I/NuV0oNDmm8TBrBfLiOuaaZt2NFaCnDmyB7wihEkkJNYMfs5liv7QMIQhMj7pI4FpxRHouCM4VcNEcTfhKwQqt8FXzSsNVq59L6cFOcsKV0HafFAL0Lh7qJ4vw7vfMNe+LYKn8i3QOgyjyz93A6IAQRwDOOFUjqtMQfZr8Bt0EpVQ1KrM2MGNnXxvGs+e9XBWzGzSMkaOjVtv/p2WhC9qUFkkvGzi4j4DbJPw27HbrDcDt3i2XLkVK/FuDtcsR1k6illA4xtFaZtmkJO58hf5Jjq15O1iNWLyg34J2bnB3KrnYs3NQV1y6E/hRT1Qrsbk5akoZ0TYoqgCSsoVOjIIqnFBljCL+nZ0XVnuFXkV799jVn1f9G1EOgfFaUBnt++0a7+tF/M2CwcAI0AFCB87Wen+jITWQcNWnxnyh0QarLAHv4Axb82aKfB45Fn+wkG9T5PZqywLqYfE5Xt22NedIjDlTlP/dgXbeQq6EOcIKziE2HBtuoHGOcZOV1XEQIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(53546011)(71200400001)(5660300002)(316002)(110136005)(54906003)(83380400001)(4326008)(38100700002)(66476007)(66946007)(2906002)(186003)(64756008)(33656002)(508600001)(66556008)(6506007)(55016002)(86362001)(66446008)(76116006)(122000001)(7696005)(8936002)(9686003)(4744005)(52536014)(8676002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2puZE1yWmUyOFMyeHllZnBjWFVMSEhxVDV2cnZBaWNVMk92WFFla1lmNDJM?=
 =?utf-8?B?UkNZREFhajBxeW1aekw4OXFwSWgycHA0V2RpT2U1RmdBR0VqNDY4TXo3ODJE?=
 =?utf-8?B?dmZEZFN6djlHaGx6NmNmMDdxZ0VBekJxVUx1V1VrQUIzUy9weW4wTzZaSy9r?=
 =?utf-8?B?Q1pJRENQUnZIeTNWckprOGE1azFETzZJMmpCU25VdjArV0dZQXRncGpnbkZv?=
 =?utf-8?B?ODl5N0JvYkpBb2RSaGNLSXNEYXhVM2pHZThFNG82NXdpUWNJOEoxcWpwbHhL?=
 =?utf-8?B?ajJMU3hURksrck5EUUNXWGVzeENTbVpsRWJJcGxjRld5RUVHeTJkbi82VHE3?=
 =?utf-8?B?YXk2Ukw0ZXQzRkU1aXV5T0Fzb281VVVPcmV0dzA1dWQrbXFrNWhDNHNFWS9k?=
 =?utf-8?B?NDdHVjkvNlJQTGdBZ280bTU2YkVaUGI2NVdja0ZDWTBZS3JwY0tDZ3FuKzVh?=
 =?utf-8?B?aktVQWJUTEgwMEcvVEJBVGlqZklYV3BsblhhYU1GZ1VpbHA0RVFNWFdET3dU?=
 =?utf-8?B?aURwdys4cW1STm90bm1oRHFZeUY2YXo1RUQxbUhMUE9KQnJpaVRTWDhmS2dk?=
 =?utf-8?B?S0p3b2xYMG1Kamt6V0JvYXB6aFB5Q1grTnVrcFlpbDhmd0JML0RBMnA5TEtP?=
 =?utf-8?B?VW5wQnowM0NHTElvS0pBU2NqMExjZkdnM3pBRWh6SWhmc0NxdFFYN1p0KzBk?=
 =?utf-8?B?TXA3L1FTL3prcVFKdGtkN1cvRGc4bXUrZkl1RUFYMHZ4d2RhcDRzUXZhMW5x?=
 =?utf-8?B?d0NVQ2VuZWFtblVrVHFRaW9WVXVkVFFaR3BlUnhWcVpoenkyZGdqeU5Xazl5?=
 =?utf-8?B?QjY3b2lsRVlHb2M0c1duTVVPRUxlZGlGaVFlTFBCTGpsM3hCREdldXI3UU8y?=
 =?utf-8?B?RC8vdnN3bTlFQkZUckJBMXR6M3RCUGFMVU9NYy9tbUlUOFZXK0FDa0hFMU05?=
 =?utf-8?B?UWJMVU9PcjVTLy93bDZRRFprTjB6UFNHUjE5NVdGTWJoTXpTSXZESGozZ09V?=
 =?utf-8?B?OWE1WHRtK0ZtUm13dUVGdWhDRmoyL09TUlJtODFSVkFIMjdHS2IybTArM0wz?=
 =?utf-8?B?b2t2eEVBMVhKd3lIWmUxdUFCUzZNKzFsODVkczFPUjdOUy9RWFAwdHlOZTZt?=
 =?utf-8?B?Rmh5eDU4Wkd1UlBxV2FWdkd6MitOZytEK0dpbHlGZmRWMk01K1VkS3dUOUZ2?=
 =?utf-8?B?TkFIQ0ZWcEZUL0FmNHpoeUZwSUg2SWFVbUNpeDZ1TWtBQzNEUWlQYXF4S09M?=
 =?utf-8?B?N0Y2UHlxSHBMY2ZEZDh6MnUxREF3aWZYdTk0cWV6cTBNSkQ5U2NZY1dzZER6?=
 =?utf-8?B?SGduZHdMd0liWFhWL0N2OW5BMERLK3FBK1d1Z1RwSVhucFc2VWplaFZqVzA1?=
 =?utf-8?B?MEY1ZmxBWE5xS0RKY2pidUIwNkRINlNkeU5RaTdFRnVlUFJ4OWMwSEJ4alha?=
 =?utf-8?B?TGRTTjg4MDcvMjJ5R3ZxL1RwSk5SUFcyQ1hVUGJQTnBoNW9TSi9YSTBrdlI3?=
 =?utf-8?B?S3I2OE1hSzhLck9MQjFaZGJ5UjZmeVlMVzNkZThnTXREYnRNWkp4eGhJR1I5?=
 =?utf-8?B?UU5zdUlwc2IzcjBjaFdCbjY4VkpveFVoNkh1ZUlZQ3VoYUlrSUFMY1RjWGY1?=
 =?utf-8?B?WkgzNnVNWFR4QlFRYUJuMXBHcU9Rak5RclNON0FvU1hqc2Rxb1JYTUpVRVFw?=
 =?utf-8?B?bUtjTnpkZlYzeGxjUGo5eHN3ZnJuR2ttcFh2OXlzMHVWbnFmdzRUdUQwZ3JX?=
 =?utf-8?B?NEJyUjJLbkx5SzhJSWVUb1ZRMU82UlFxU0plNlk1NXBEU0tLb08rZUJtRGhW?=
 =?utf-8?B?dUtENmg2M1Y3UXFmdWRKRmFlbmNkbXNkNW9Tb0Z1VEZLWlpWOWlydi93Vjlw?=
 =?utf-8?Q?bwOcjtyPkzzSc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8c63b4-286a-4cb7-c562-08d95037798b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 13:15:44.1512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7M/JHh0lQ7T+XR1uxMr4O6/dFvLXUjtNjySGVu8JzKU5jwpLXqnZaKbFJsnc5I8Pk9giwBeofeChrYI2o6rqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0791
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: ktgGmuKOnYP3brrJnT9M1DPwiE-lqv1Y
X-Proofpoint-GUID: ktgGmuKOnYP3brrJnT9M1DPwiE-lqv1Y
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_06:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 phishscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107260075
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBaaHUgWWFuanVuIDx6eWp6eWoy
MDAwQGdtYWlsLmNvbT4gDQpTZW50OiBNb25kYXksIEp1bHkgMjYsIDIwMjEgMjo0MyBBTQ0KVG86
IE9sZ2EgS29ybmlldnNrYWlhIDxhZ2xvQHVtaWNoLmVkdT4NCkNjOiBQZWFyc29uLCBSb2JlcnQg
QiA8cm9iZXJ0LnBlYXJzb24yQGhwZS5jb20+OyBCb2IgUGVhcnNvbiA8cnBlYXJzb25ocGVAZ21h
aWwuY29tPjsgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IGxpbnV4LXJkbWEgPGxp
bnV4LXJkbWFAdmdlci5rZXJuZWwub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSCBmb3ItbmV4dF0g
UkRNQS9yeGU6IEZpeCBidWcgaW4gcnhlX25ldC5jDQoNCk9uIFRodSwgSnVsIDIyLCAyMDIxIGF0
IDExOjM3IFBNIE9sZ2EgS29ybmlldnNrYWlhIDxhZ2xvQHVtaWNoLmVkdT4gd3JvdGU6DQo+DQo+
IEknbSBSSEVMIGJhc2VkIGluIHRlcm1zIG9mIG15IHVzZXJsYW5kIHNvZnR3YXJlLiBJIHdvcmsg
b24gdXBzdHJlYW0gDQo+IGtlcm5lbHMgdXNpbmcgdGhhdC4NCg0KU2ltcGx5LCBvbmUgaG9zdCB3
aXRoIHRoZSBrZXJuZWwgNS4xNC1yYzEsIHRoZSBvdGhlciBob3N0IHdpdGggdGhlIGtlcm5lbCA1
LjE0LXJjMi4NClRoZW4gdGhlIGZvbGxvd2luZyBlcnJvcnMgd2lsbCBhcHBlYXINCiINCi4uLg0K
IFsxMzg3My4yNTUxNDhdIHJkbWFfcnhlOiBiYWQgSUNSQyBmcm9tIDE5Mi4xNjguMS45MiAgWzEz
ODc3LjU2NzQ3NV0gcmRtYV9yeGU6IGJhZCBJQ1JDIGZyb20gMTkyLjE2OC4xLjkyICBbMTM4ODIu
MTc1NTQ0XSByZG1hX3J4ZTogYmFkIElDUkMgZnJvbSAxOTIuMTY4LjEuOTIgLi4uDQoiDQoNCkNv
cnJlY3Q/DQoNClpodSBZYW5qdW4NCg0KWmh1LA0KDQpJIHdhcyBhYmxlIHRvIHJlcHJvZHVjZSB0
aGUgZXJyb3IgeW91IHJlcG9ydGVkIGEgZmV3IGRheXMgYWdvIHdoaWNoIHdlcmUgSUNSQyBlcnJv
cnMuIFRoZSBhYm92ZSByZWZlcmVuY2VkIHBhdGNoIGZpeGVkIHRob3NlIGVycm9ycy4gV29ya2lu
ZyB3aXRoIE9sZ2EsIGl0IGFsc28gc2VlbWVkIHRvIGNsZWFyIHVwIHRoZSBJQ1JDIGVycm9ycyBz
aGUgd2FzIHNlZWluZyBidXQgbm90IHRoZSBvdGhlciBwcm9ibGVtcy4NCg0KQm9iDQo=
