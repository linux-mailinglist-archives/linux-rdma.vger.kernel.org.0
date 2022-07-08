Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B956B3C7
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiGHHq1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jul 2022 03:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiGHHq0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jul 2022 03:46:26 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D977D1E2
        for <linux-rdma@vger.kernel.org>; Fri,  8 Jul 2022 00:46:25 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26851JE0013069;
        Fri, 8 Jul 2022 07:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=HBkCyAOrJ/urYOztfsCfqTbT3ukSvjqguhGjhAHlemo=;
 b=j9un4n9R7H+aQ0/fNrHM1DW/q/cX9Io7/FYV3No+V3yk41rqdUYV8SUhQiod7F2ms4JZ
 /sxZq9wNachnnliOkGHwvJMd6cWgs9W9PbK70tGmjjN3h7y8PX3meCaAT8lLjF1aI/xT
 lgDg7ck3C8mJwX8sBoFoNyjO/dynkL2TKlBIVMhGklB3baIy3k7XHp4hd99Cn7S3AtAS
 LL8exLWU7zLGFcjVdl3g3lo349t4v661yV41fLLa/atpVHRcXdtCTxvWXQdWQ1XYUj3V
 t+bSEuUsdWy7pyE3fHMT+19WFgtEJPPa3jyLWELAjXMJZm68MACS77TGJEU8Bew3k87l Yw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3h6e2hhc81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 07:46:14 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 15AB714787;
        Fri,  8 Jul 2022 07:46:13 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 7 Jul 2022 19:46:12 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 7 Jul 2022 19:46:12 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 7 Jul 2022 19:46:12 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 7 Jul 2022 19:46:11 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnljRopmFtiVOn5I6cFHJtD+owjhUA3wX6HLuidR3pu1yq4d/QuGgBYw1562bctMtjVte8duLM2B810Ae3jrSmnwtsOi34fNMp8vt4fj1Z26lz8OrSZbRg7t9ksX81O467FLpnakDEl6WlqwNqyAhK9Z7IEZy6efKQagkESGJA4sb3thiAU0JeSe0MEeKh1H8/KOKMpztpAqQV6Mm9GuYdeA6bD4hSUZiQAcd4ojY1KFglGusFAIkv2tt83IsTuwTOR/gAgaLmH4LMPnyNZ6EbV+ylLxhsZl4iQAD0osOpT9vvSCfONQH/Svl7QFCN19Lvph+BAMOIbxd383s7zqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBkCyAOrJ/urYOztfsCfqTbT3ukSvjqguhGjhAHlemo=;
 b=VHWJBA6A5aF7yXxSzjxoQehk4Pvg9B3rdo9FFHBxpwL4oMo93YQ5r28qQZaZ/9PHyTWUZzRZHyNL6M6gsa5bO8oJBEHmAucFZhUF867Qv9aoC01RnFxby2McIn1zEnv6paw3x8xH+RTE5VK+odsoMSBzDf6ea5rJ+MdaB+sSqhQ5SCuSJVguLYdwru/Ub9qhHN9q3mFQHlvAWAUheqtz/sbOEVnAgL/Zm1lDk+PFJrQpRpM55BTaa7LvYve+Q2/CI6/AHu/VZishdzztEqzjOnwxWPIFLQeZYHWhMngXjaBlgj/6CldhTMI/UKrTyVYzVGQl+qQxndfmlK+7nEsDdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by SJ1PR84MB3066.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:45f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Fri, 8 Jul
 2022 07:46:10 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455%3]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 07:46:10 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: RE: [PATCH] RDMA/rxe: Process received packets in time
Thread-Topic: [PATCH] RDMA/rxe: Process received packets in time
Thread-Index: AQHYjvWIlKMfas6eCkeo6hzkrj011a1uLNCAgAAYjgCABcYIgIAAE8eg
Date:   Fri, 8 Jul 2022 07:46:10 +0000
Message-ID: <MW4PR84MB2307B1FC7BB7FE0EDDF3BE2DBC829@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220703155625.14497-1-yangx.jy@fujitsu.com>
 <20220704125541.GB23621@ziepe.ca>
 <fde68be8-d067-f0d3-b2e9-2226e0e45f7a@fujitsu.com>
 <416a459a-2b27-7538-294c-1f2362a2eb2f@fujitsu.com>
In-Reply-To: <416a459a-2b27-7538-294c-1f2362a2eb2f@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4738c30-f952-4cd0-498e-08da60b5ec9d
x-ms-traffictypediagnostic: SJ1PR84MB3066:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8QqGttsa4To8s5LZvlziQvfsmjSHrLXSzFIHV9u+wMIsoBbavvlwqQimr5fTvil2/PplwBBOJCGpQP9Q4jnDZ4W/esYGlhmKn1/7KRWuzpVkOSO5L2YDjPCtKPQ2Z74nXLfbt82g2hvIHw3Yo81RKwdTKerSDRZbT2C0ZX7t914pwkpvyC40H+KZ/vn5OhPGHE20RWjtbM97nhF4wnipKOL3GpQs7tpjykoCB4psAL+6ju2IbYI6Q680tfFRWHfR9APA1vEWxMElIs/BxcAfhNL//G68v0oI7aBNoeuTfwq+EIJcVzjlfdZBfP9yg/yosZKfVDXmlx9OwDT6sT/L3CkpRJWLWsxaxu+j7Ou7uaPRzjJSFGsqFxv3UVjzt/CDwS8bO2pQ5R0+qtpvCHF9/Sy9lw65wMsvgVJm1/+ZGlW/6wIWM4ykTjPuhpKNTlzW+tvAbBRQOB3c3FDAM3if+pLVpOyy+HyXm34YqXYNQEiyCsKh3lpbVCiq9u7UGUOZ3JY89U1Ft4slgKhMBZkjqzhLHmyH1DeiaUYT4xCMLC7GjkMRGrmQC/gBsjF8XiLAVgurhC+8Y6nE57NrzzyxUwgLJfo9yvduiPhkAFo4w+vmZg9LOXX4gVv2blZORfiH0o6Vk2bjMaxApz7lHL9mwSYL+4Z3PTP90BIVvkjCsgzelEw9lJhzqkIKetssOEwko7kN7x+Zwmq9V8VJl+Gnkau666jyeAXnDqt5nUIDhiM1HuJE/Gl/3qqtpUO/ykwEa34/h8qXGw9E0O+CV1DqJIBBl3miEvlqWubqQP1kRsm3D/Ce0Ncfi8S8g9rIFLMa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(136003)(366004)(376002)(66446008)(8676002)(478600001)(66476007)(4326008)(41300700001)(26005)(316002)(6506007)(64756008)(71200400001)(7696005)(76116006)(8936002)(110136005)(54906003)(66946007)(66556008)(2906002)(5660300002)(33656002)(53546011)(38100700002)(82960400001)(55016003)(83380400001)(86362001)(186003)(38070700005)(9686003)(52536014)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHpzTjZhU3FDSzBtanM5cEROV2YrQ1pXTEExSFZ0cmg4SnFBUVZmbWY0UndQ?=
 =?utf-8?B?RUFRK3JoR2ZwbFcvQVM2d0ZrZ09nYXkrVUdhL2NoZkl4SWtMTVpyTUp1K1N6?=
 =?utf-8?B?dkdYOExQZjloSzZ6V21Rckh5ZTJvRnphYjJiQ3MrK28vblpYWUFWNFJKdzhP?=
 =?utf-8?B?eXdrREo0S1MwMTJkNnhLRUlXdXI1MzBJbHUyclBsQURsdElVakZKZVV6VEJJ?=
 =?utf-8?B?QmlYdXBpcGFmck5qZ3BiVCtzRW14VHZwem80OExQUnM1WGdabERtK1pkdXVI?=
 =?utf-8?B?UlVBMXJEdGxBVHIrSGdiNEs5VHpDdzR2YzFTR0haRkJ4UEtZOWs3Zm9XNU00?=
 =?utf-8?B?SzJMWkttWXFpbXhjWWxoTXZEUzF4VnFGbllrL3R4bm9Kc1czN1VTNlhZYTky?=
 =?utf-8?B?Sk5RdW8zeFJ6bWRLc1JmWVl3aGdSMFBHaDRzQUJ5N1FENndWUEUycEVac0dN?=
 =?utf-8?B?bkoraFdBdUtYRlVHajY0UlFzSUlJR2xETWdSM3g3MHFYT0R1MEhqcDVnanVW?=
 =?utf-8?B?MXdmZG91VHBmNDB4MXdCVk1JYVRoUW1HemljOUFJa2w4eHF6R203R0pneU9P?=
 =?utf-8?B?dlJKL0Zad09rV3Rab0ZEQXNuTkN4UlBFTFVKMERwbGh3dy9hNXVNeDI0TGFH?=
 =?utf-8?B?TWxid3ZCSVh3NVJZaDM1NzJmZ3U1ZWFKbTNyeVZRaDlLRVp4YWJRV1hRYlM0?=
 =?utf-8?B?dUpDd2ozTGVlTU1ldHdpeGdWaHZaM3VjNGYrajQ2NWZWa3AzcE1WelB3SDVm?=
 =?utf-8?B?TS9lS21mYTVxd0FBcXNoc3pBeGZhLyt6OFNEaXB1anhYeTk3RzN6Q1dHaTVr?=
 =?utf-8?B?QVZZNFNxWmlIQUJFM0lROGpRODB0RFRNSExEOXRHbWFOc21HbjcrMTlRMFNH?=
 =?utf-8?B?bUcrelZTWTVzWi9keFVoNlBNa1RFM1kzN0RGcVlJaW1rT0tMNDlLQ3N3WVZ0?=
 =?utf-8?B?U2Y3T0djaGhRc1FyT2FUcTRxd0x5Y3psQ0w2S0ZneHp1eFpEcGVjTHc2VUJa?=
 =?utf-8?B?Rlhld1JiOWZ1aWtUeFFsYVRJbmhlekpQZ2E3OXhGM2NSc1k2L25BK0N2WUpZ?=
 =?utf-8?B?cnFCYmFLVUp4M25OWTNCd2d5TER0enBzWGRvRkNBWUNNYkcyVmxtZ2VkWlc5?=
 =?utf-8?B?clVVc0FQRG5WdHl2OFpHaGkyZE8vYUtQZnNMSWNoTGMzbjlCYlZxdnNUay9r?=
 =?utf-8?B?Yk5SZXpCdnZrRG84YzFUR2R4d2ptWkFNWnR3VGlUYlovTjc2emM0WnNtTEc1?=
 =?utf-8?B?SERiMU1idlplc3ZCVTh4MUJ0bUoyWGxKT01IR0FIZ0U3Ny82NVNLYlRYVE1k?=
 =?utf-8?B?Uis3WW5FLzVjbi84bTY2VlZtMTFOd3F1dkxyK1ptZHUrUk1iZTd5THpBWk42?=
 =?utf-8?B?OHkzS0VwVGt5aUFqSGRsZXR3QkR6WGxxc1dmUm9Zay9LR1ZYU2RNMTMzTWpJ?=
 =?utf-8?B?QlQxSVk2RXdHODNFSkM5czN6anhTOXM5TytwTE9PdU8rQ09RZEkyOXBLM0o2?=
 =?utf-8?B?YU91M1Fzc1hRMEJyeC9Kc09ja1BqSi94SUxWTytyQ01zaEZUZHJWTm41aGUx?=
 =?utf-8?B?V1M5N2NRY1pKU0NVSTJ3aHg3N29JaXNZZUg1V2d4SFdjQ0hWRVJGckpGK2pI?=
 =?utf-8?B?eTdTL3ZTN25ZTENpVzZsZitWYjBNcXZ2bXZOcnVTM2YzeHZZZ3BzRDl6NUNT?=
 =?utf-8?B?dXFzdGZDQWxSSHJaczczQzVGSGZtRXBzUjE4TjVKWDZ6cmsyZjk5aWgwc0Y2?=
 =?utf-8?B?NGlzZzhBME45ZGY3WlRWT0RhL0s3bVIyK3cxRlp4MDF6WkNBTXJXc1d0bHpS?=
 =?utf-8?B?cmg0N2NNWGVWRE01OXFDeUtpRWg0ZzI5dkRqV3N3cndFN3BLcDhvdTNvbzJt?=
 =?utf-8?B?R0J3dUNmU1VwSXdJaklET2F2QVFES05nS0NVK3Uxb3FRK3J5RVdwYTBJZ0kr?=
 =?utf-8?B?VU1ZMGhReEJzN0NsNmdjWGZaMGhKUm9RQUw2dXg1ZjNGL2pqTkJib3dmbUk1?=
 =?utf-8?B?VFVJbkVHTEFZRW4vN0tqU2l6cHE5MzIrYTlsM1lMd3ZoUGF1MFdoVzV6b01Z?=
 =?utf-8?B?cEJZUWVKV2lVRU1Nc0JHaC9uVmcrajFNRXhEdWlROFZXRHdWUmtCRFZ5VS9H?=
 =?utf-8?Q?+OfDzNno3GQyb5p0Ys0Xjn4QO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d4738c30-f952-4cd0-498e-08da60b5ec9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 07:46:10.1267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9heVzA+iRI8EZaT2A/mrptqf7kgloKqZX02luH1DXtnLpi8tmwu3/WL+KRZkOC8V7hNwYTHQniAkaUFPyhxaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR84MB3066
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: TAtGvA-oS7ZIJfYRgx1EYH49Kj9Uj0D5
X-Proofpoint-ORIG-GUID: TAtGvA-oS7ZIJfYRgx1EYH49Kj9Uj0D5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207080028
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SSBhbSBvbiB2YWNhdGlvbiB1bnRpbCBKdWx5IDEyLiBJIHdpbGwgYmUgaGFwcHkgdG8gcmV2aWV3
IHRoZXNlIHdoZW4gSSBnZXQgYmFjay4NCkJvYg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogeWFuZ3guanlAZnVqaXRzdS5jb20gPHlhbmd4Lmp5QGZ1aml0c3UuY29tPiANClNl
bnQ6IEZyaWRheSwgSnVseSA4LCAyMDIyIDE6MzQgQU0NClRvOiBKYXNvbiBHdW50aG9ycGUgPGpn
Z0B6aWVwZS5jYT47IEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+DQpDYzogbGlu
dXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxlb25Aa2VybmVsLm9yZzsgenlqenlqMjAwMEBnbWFp
bC5jb20NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIFJETUEvcnhlOiBQcm9jZXNzIHJlY2VpdmVkIHBh
Y2tldHMgaW4gdGltZQ0KDQpPbiAyMDIyLzcvNCAyMjoyMywgeWFuZ3guanlAZnVqaXRzdS5jb20g
d3JvdGU6DQo+IE9uIDIwMjIvNy80IDIwOjU1LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+PiBP
biBTdW4sIEp1bCAwMywgMjAyMiBhdCAxMTo1NjoyNVBNICswODAwLCBYaWFvIFlhbmcgd3JvdGU6
DQo+Pj4gSWYgcmVjZWl2ZWQgcGFja2V0cyAoaS5lLiBza2IpIHN0b3JlZCBpbiBxcC0+cmVzcF9w
a3RzIGNhbm5vdCBiZSANCj4+PiBwcm9jZXNzZWQgaW4gdGltZSwgdGhleSBtYXkgYmUgb3Zld3Jp
dHRlbi9yZXVzZWQgYW5kIHRoZW4gbGVhZCB0byANCj4+PiBhYm5vcm1hbCBiZWhhdmlvci4NCj4+
DQo+PiBJIGp1c3QgbWVyZ2VkIGEgYnVuY2ggb2YgZml4ZWQgZnJvbSBCb2Igb24gYXRvbWljcywg
ZG8gdGhleSBzb2x2ZSANCj4+IHRoaXMgcHJvYmxlbSB0b28gYnkgY2hhbmNlPw0KPiBIaSBKYXNv
biwNCj4gDQo+IERvIHlvdSBtZWFuIHRoYXQgSSBzaG91bGQgdXNlIFJETUEgZm9yLW5leHQgYnJh
bmNoIHRvIGNvbmZpcm0gdGhlIGlzc3VlPw0KPiANCj4gSSBkb24ndCB0aGluayBCb2IncyBwYXRj
aGVzIGNhbiBzb2x2ZSB0aGlzIHByb2JsZW0gYnkgY2hhbmNlLCBidXQgSSANCj4gd2lsbCB1c2Ug
UkRNQSBmb3ItbmV4dCBicmFuY2ggdG8gdGVzdCB0aGUgaXNzdWUgb24gbXkgc2xvdyB2bS4NCkhp
IEphc29uLA0KDQpJIGNvbmZpcm1lZCB0aGF0IHRoZSBmb2xsb3dpbmcgcGF0Y2ggYXZvaWRlZCB0
aGlzIGlzc3VlIG9uIG15IHNsb3cgdm0uDQpjb21taXQgZGMxODQ4Mzg4MTM3ZDIwZTU3ODZiOTc2
Y2FhNDlhMjY4ODlmMzZmMw0KQXV0aG9yOiBCb2IgUGVhcnNvbiA8cnBlYXJzb25ocGVAZ21haWwu
Y29tPg0KRGF0ZTogICBNb24gSnVuIDYgMDk6Mzg6MzcgMjAyMiAtMDUwMA0KDQogICAgIFJETUEv
cnhlOiBNZXJnZSBub3JtYWwgYW5kIHJldHJ5IGF0b21pYyBmbG93cw0KDQpJIHRoaW5rIHRoaXMg
aXNzdWUgaXMgcmVsYXRlZCB0byByZXMtPmF0b21pYy5za2Igd2hpY2ggaGFzIGJlZW4gcmVtb3Zl
ZCBieSB0aGUgcGF0Y2guIEhvd2V2ZXIgSSBhbSBzdGlsbCBjb25mdXNlZCBhYm91dCB3aHkgcmVz
LT5hdG9taWMuc2tiIHdpbGwgYmUgb3ZlcndyaXR0ZW4vcmV1c2VkIGFzIG15IGNvbW1pdCBtZXNz
YWdlIGRlc2NyaWJlZC4NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+IA0KPiBCZXN0IFJl
Z2FyZHMsDQo+IFhpYW8gWWFuZw0KPj4NCj4+IEphc29uDQo=
