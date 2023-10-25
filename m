Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6677D6D1C
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 15:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbjJYN3m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 09:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343840AbjJYN3l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 09:29:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A93F12A
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 06:29:39 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCqZVO001202;
        Wed, 25 Oct 2023 13:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1+jobstgCvM6m2BW98k/AybiVGSeqH15/henGYtfnH0=;
 b=dB7eQfjGv5fIfgiQpL7+WWqu9WcPFtM6dhkeT4aC+ZdESj/kEdmj1CsExA4059FU/bvw
 6oy0+LXRibnDGMuUbdP4WhWQ1J6xgDAbLscNKYiSq/oV5A1f9b8d4wnkQyQaP7y4kIHP
 XztDJLJei/dk2FSPBScu3cp6uMjAqrZMmS8jHpsNuGwk+cMWEsi0CPCaSJYoaXzQg4t9
 oDHvYKb/lEGzC8N2OQEFYVZEpYif0+oxYWD3waeMqW1YpBwJ+u/b4jNcW+yw0Rp+WsvH
 neRwTfrUQKdshpH80nDrtIRz8oY9IW2IwExb9DtN0bLxpVE2pr9nFzoWPaA3eHJzT4r7 VQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3dgh7m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyaDkTY/aKUz045v3jVRPBMgEw0NfIxiCO0wdCfzzpTmTyzaasKn8JA6dwPM6g6wZXaKsp7vGJEyYIRdei5/ds7vb4oWYPDS6vG81CUZAE9L7lphNGuCRIHyjUowvDT44sAe2BDxC0jG9FKNkFrVBeFE8fsUl9mbNd0IeIOVruhAvegG03dJAhdR4CziWSBLoAjk7Wi9T9JusbV1W9x5T9Rh8xyzNzabq8QX8e9yEAzVjUGACBY0zfdEah5+88a2k8gqlhQ13uTIdZ4ml1ahNRjcUJfcIvXec+Ntn6rie2DAHP975ZMNFdsub5EQFnKKrOKEl2DAfxQ/CeZ4WRKGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+jobstgCvM6m2BW98k/AybiVGSeqH15/henGYtfnH0=;
 b=le8Cdgx13UFdSG5sSxEin3YdUvhOWf0hKr1UWrRNrrxV5zIpm6vV9kFGPfeXX6f0+UrMYpbNcUi/WRcAWK3Qv4WKne84+Hqn5af8ZEi5dzq9BwMEzH/HMnhVw4JMw/fgtqhEJZvlUAMdBWzDjF8QK5izgy+0OsWntb57XmNq87pq8Nr3R05eywLCSokobiVhTDmuPEAWSwEs17+SZGudUi8Y4APaaHMklvvv83LJRfmHZYQSOI916oBjQReRWxbFQlVPJrpnXmG6dLffoJnHYbOQO4KnOY8/NOZK968JX7suUUjRMTxxJN1MwjtnkBi6CcTw1TndkfvmbkZ795KePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by LV8PR15MB6440.namprd15.prod.outlook.com (2603:10b6:408:1ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 13:29:32 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 13:29:32 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V2 20/20] RDMA/siw: Update comments for siw_qp_sq_process
Thread-Topic: [PATCH V2 20/20] RDMA/siw: Update comments for siw_qp_sq_process
Thread-Index: AQHaB0dJ4w/2bO/r5UW9UPNRhiKd0Q==
Date:   Wed, 25 Oct 2023 13:29:32 +0000
Message-ID: <SN7PR15MB5755AE5D35E4B036CEC105BB99DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
 <20231013020053.2120-21-guoqing.jiang@linux.dev>
In-Reply-To: <20231013020053.2120-21-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|LV8PR15MB6440:EE_
x-ms-office365-filtering-correlation-id: 3ae84878-00b2-4c6d-d099-08dbd55e6c68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BTFaz2WJYM+2oYGm8wQY6Ip0c4DONKSLXZHCWH5+Ed1aTOXTEdWoaBRa3bMiWfSZTrw95B1bg2B8uuN5ktVqvriwNH+cN9fdv9lRxT5s6PiPogYfa9pRuf2nAcS27ffmEPlxwEfD9ws+tpf8WJ/klaVfxQPdWyKAQO553Y6LulIiLyjsBkP4/H99+HfIfOCrCUxmkwSq++6fGshtyXbsRdRo2TiPNKFKmb85GF663+CtxgO0ybDddOQhKrS4/kahCm7h0vhUgzmkqd7lzSn9RGVncnvEHHxIPVNB7aCPL0uCKv2/UAcyDt62bHPtzXtJYJVTLy6NM/vLBgkkASNuDng+ouK7WxZqqZHVPuB4Brd1teu1PrYNfJdxpF5mrBefVnqlhNCJb7SBlyw9URqBMA70EofD/0vq/V3X90Zm2yDhFtzjlqRGZOj+oCa1OW5cC8Z2j9LaXRtpHVSOIRB/u8PCPmvyiTziP8ykvx0w6rLHOCa0Ngr1B7tZTsMpW2PBlLg+fmTzRvH7NE9kAlM0DGTnQq0Eb8KBVx+ma+i9I+340TTOQOWSIhdyc6R84enIEegvSL81TvSDVtN/j44IOHZViRf4ctFPK+ZcxhI2Q+DQ+GlerJ3VAieTGhOVpnVQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(33656002)(55016003)(76116006)(66446008)(66946007)(66556008)(64756008)(316002)(38100700002)(122000001)(86362001)(38070700009)(7696005)(53546011)(83380400001)(2906002)(9686003)(71200400001)(6506007)(66476007)(15650500001)(8936002)(5660300002)(110136005)(478600001)(4326008)(52536014)(41300700001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGpGYkMyOG9oZEY1MnNkRHJwejZ5UXpyVEtrWHNmWjE1VGdoZ1JlVnJyT2hC?=
 =?utf-8?B?K3ZHSzdmUzBYTmlweGgvd0N6YkZ0cW9QZ3VvdXpabWthNDNER0JHbEVWQjd2?=
 =?utf-8?B?enI1VWQ5c3hoenhwazVGejlNVGJBdkVXYVdNRjFhMlgvOE1ST1pXZjh2SDNC?=
 =?utf-8?B?bkxXQXFFMUxaWU8xOEFLZG9Nb3NPaGUvSVdiQ2tEZFhIekNzZXJUV1N5dzk2?=
 =?utf-8?B?UmhFNUluSmViUXRlRWZEK0p0YjFmZ2Jpa3pKRjdpdTBySGx5cmNEdE9XNzZO?=
 =?utf-8?B?eHA4UVBFWTRVRGhLUTFhTDVVenlnRExjMGRVWkUybzdWRE0xd3lzTDJQQmJu?=
 =?utf-8?B?TEFzdjg2TVZ5cVM5aDBtaGozUVlHTDlrM3Y5MHBvdHJGWldUTXZSeE04Q0sw?=
 =?utf-8?B?RkpNb1lxYmRRZnJGNkVwbDU5QU90TkdRT1J6dytmaDUzenVoamZEZU8wYXZQ?=
 =?utf-8?B?RUY0OWY5eXJiRHFrZDAreEgvVEFFVVppMHlmaEI4eldnem9vT0t2K080UFRa?=
 =?utf-8?B?aG5JSmYyNlA3YUpmNTNyVjdDNGpqZzhOeUpVa2JaSjRlaktNbHhhZCs3ZUpx?=
 =?utf-8?B?bVpCOTJZTkRoUXJSS09sN1lCWTRodnhVa3lSTW5sSWRrZVl1dUVrdk9hcnR5?=
 =?utf-8?B?RWFEamlzcTczZmsyMWtKZ2M4TUVyN0lOM1hQbjhRaExwTVcwQUZnS2Roa01W?=
 =?utf-8?B?NTNlS0lvcmovQ1JFSVhCUXNPZ2VVVDhiSitodk9RbWZxZkNGaldkTXFJK2hW?=
 =?utf-8?B?dXlha2hUTm5XZFhSeUIyN291OXZ0ZWJtREFoL3NCVHpXakhteXhIZEt0dUtS?=
 =?utf-8?B?WlVteU1OQk90YjR4OTVqSkZsSVNmYjFuNXBHWENLOWxHMXlZeURZZXQ4RU1m?=
 =?utf-8?B?b28zeVh5T1FGczRLZ1oyNm05VWp0OE9ZUmRrY3hLaHhKNGhSbHBkUW9oWUhU?=
 =?utf-8?B?Rmt3MzgyTWNtS0Z2NDU5SWJjS1ZZQlFxQVFwdVpJMHRFODlkT1BQQmp5YWlv?=
 =?utf-8?B?T01SZDdhNWFraEFSNGVyUmhZNlJhY0poNEg3MVUyQlZRRGRLd0tKc0ZOY0dW?=
 =?utf-8?B?d09iV1h6MFFkamxOUzl0Zjh3WmwwQ1hteDVGUktZUklwajN4R2REZDczNkJD?=
 =?utf-8?B?dUtXd2tlc1ZzWVpNaDJlU0NwVXNNZGw5Sk43dE5CaHZkYW9CUDZMbWFoWWpQ?=
 =?utf-8?B?VDZhSTFLWDQ2M0dSOUM0TWRNNkpmUG5lVG5sM0p1bHdQbmlXWWdWdWdvaWp0?=
 =?utf-8?B?WlR3aitpTVptSXk5RFlDTldGZkFHZ3drZW9WcHFRbmpTQm80bWhmb3Rudnl2?=
 =?utf-8?B?TGhtVEJoVmlYMHRLWXQrNkpwRUxoVkg2S1RaTHk1ZzNPMkVGMitSNUkxK2dw?=
 =?utf-8?B?d0hCcUtrYWF6SU5maDRLTmhtd0dCdkVTMWtZSnAzMmZINGVQM3MwdWRNSVBs?=
 =?utf-8?B?eVd0Tjl4OWJiUk9ueEZhbVdzVkY1cG45QTVJSUxQOW1YcFZGY1VkczY2L2F3?=
 =?utf-8?B?dWRHY1d3d0xXZDRiUGxsQXRRL21WVHNuZkM0YmQwRUJaemgzRWcwY0RlZFli?=
 =?utf-8?B?TnZjY2p5SlgyWmZRb3dqS3RBTEM2Y2t1MzBrbUFQRUxoekt4TGY0ajRGdC9s?=
 =?utf-8?B?b0xjNmFIQXUydndta05RSFB5cHRrN2JFZUhYc2ZFcjRoOURzZG9Eb2hGMGdJ?=
 =?utf-8?B?NkNmYlQxN3FSTXkvMktWVmxLcjdqR2gxTjFRYjhVczVyMW0wOFRDc3lnSExY?=
 =?utf-8?B?Wmt2azAvbVdKOEpySy9KcUx3MXJWSUlycEpXdWNZSDJSa2RrbWhpL3NKWU1t?=
 =?utf-8?B?eUQyaUJ4NjVUK29FTlpsOGdKY2dhNEN4K2llM3NJRHNhclhDUE1KR04yNEhP?=
 =?utf-8?B?QXAySEU3N1I5NWNrRTBJNDRzMy9lK0c0OUtNeU52ZTlpbmJ0M3RXMEhWeDN6?=
 =?utf-8?B?bmUwcU1ITHVpOGl1ZDM4U3BWMkswWjhlSDd0RlM2NDFGRFpSYXBmWUhVOVZV?=
 =?utf-8?B?MjdGUlpIQTl0eVM1Y0tIRFR2RlB3TytQc2lDc09JMXFoZ0dkMlBMR1BuK3Bx?=
 =?utf-8?B?Y05FN1VsNmxwQSt5UVQrQXBPWCtRelVDWVN2b09NU1JOQlBmNjI0Z0dMUC90?=
 =?utf-8?B?QlgreU1Odk8rMy9BNVAyYlZySGR4cTA4alBYcTZnb3gyZXBEeWxaMm9UQUh5?=
 =?utf-8?Q?2AqZOT9DuxqEh9zar78Dho8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae84878-00b2-4c6d-d099-08dbd55e6c68
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 13:29:32.5096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIXEUz7JuFWriL+LStmZk6T7oYuZ/jTiLMQmXF6PDHEhr2Qh2SEy87mNvOb9cv28+jPMHo094A53xkkoIHAoNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6440
X-Proofpoint-ORIG-GUID: FfS5wkgU2sIWWnDviqJ0fX3MT0Vc_BGJ
X-Proofpoint-GUID: FfS5wkgU2sIWWnDviqJ0fX3MT0Vc_BGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 suspectscore=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAxMywgMjAy
MyA0OjAxIEFNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWMiAyMC8yMF0gUkRNQS9zaXc6IFVw
ZGF0ZSBjb21tZW50cyBmb3INCj4gc2l3X3FwX3NxX3Byb2Nlc3MNCj4gDQo+IFRoZXJlIGlzIG5v
IHNpd19zcV93b3JrX2hhbmRsZXIgaW4gY29kZSwgY2hhbmdlIGl0IHdpdGggc2l3X3R4X3RocmVh
ZA0KPiBzaW5jZSBzaXdfcnVuX3NxIC0+IHNpd19zcV9yZXN1bWUgLT4gc2l3X3FwX3NxX3Byb2Nl
c3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxp
bnV4LmRldj4NCj4gLS0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5j
IHwgNSArKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19x
cF90eC5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiBpbmRl
eCAyZTA1NWI2ZGNkNDIuLjU1M2Q4NWNiNmRiYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
c2l3L3Npd19xcF90eC5jDQo+IEBAIC0xMDAxLDEzICsxMDAxLDEyIEBAIHN0YXRpYyBpbnQgc2l3
X3FwX3NxX3Byb2NfbG9jYWwoc3RydWN0IHNpd19xcCAqcXAsDQo+IHN0cnVjdCBzaXdfd3FlICp3
cWUpDQo+ICAgKiBNUEEgRlBEVXMsIGVhY2ggY29udGFpbmluZyBhIEREUCBzZWdtZW50Lg0KPiAg
ICoNCj4gICAqIFNRIHByb2Nlc3NpbmcgbWF5IG9jY3VyIGluIHVzZXIgY29udGV4dCBhcyBhIHJl
c3VsdCBvZiBwb3N0aW5nDQo+IC0gKiBuZXcgV1FFJ3Mgb3IgZnJvbSBzaXdfc3Ffd29ya19oYW5k
bGVyKCkgY29udGV4dC4gUHJvY2Vzc2luZyBpbg0KPiArICogbmV3IFdRRSdzIG9yIGZyb20gc2l3
X3R4X3RocmVhZCBjb250ZXh0LiBQcm9jZXNzaW5nIGluDQo+ICAgKiB1c2VyIGNvbnRleHQgaXMg
bGltaXRlZCB0byBub24ta2VybmVsIHZlcmJzIHVzZXJzLg0KPiAgICoNCj4gICAqIFNRIHByb2Nl
c3NpbmcgbWF5IGdldCBwYXVzZWQgYW55dGltZSwgcG9zc2libHkgaW4gdGhlIG1pZGRsZSBvZiBh
IFdSDQo+ICAgKiBvciBGUERVLCBpZiBpbnN1ZmZpY2llbnQgc2VuZCBzcGFjZSBpcyBhdmFpbGFi
bGUuIFNRIHByb2Nlc3NpbmcNCj4gLSAqIGdldHMgcmVzdW1lZCBmcm9tIHNpd19zcV93b3JrX2hh
bmRsZXIoKSwgaWYgc2VuZCBzcGFjZSBiZWNvbWVzDQo+IC0gKiBhdmFpbGFibGUgYWdhaW4uDQo+
ICsgKiBnZXRzIHJlc3VtZWQgZnJvbSBzaXdfdHhfdGhyZWFkLCBpZiBzZW5kIHNwYWNlIGJlY29t
ZXMgYXZhaWxhYmxlIGFnYWluLg0KPiAgICoNCj4gICAqIE11c3QgYmUgY2FsbGVkIHdpdGggdGhl
IFFQIHN0YXRlIHJlYWQtbG9ja2VkLg0KPiAgICoNCj4gLS0NCj4gMi4zNS4zDQoNCg0KVGhhbmtz
LCBtYWtlcyBzZW5zZSENCg0KQWNrZWQtYnk6IEJlcm5hcmQgTWV0emxlciA8Ym10QHp1cmljaC5p
Ym0uY29tPg0K
