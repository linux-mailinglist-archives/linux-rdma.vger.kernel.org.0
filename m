Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97AC6D4032
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Apr 2023 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjDCJWT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Apr 2023 05:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjDCJWQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Apr 2023 05:22:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658BB113C4
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 02:21:51 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3338eNhM024789;
        Mon, 3 Apr 2023 09:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=Hi8+lmnDNPJp7OXLHPspygcKHPPoKbD+G/LLWMFxADc=;
 b=LoYRTfV4vDVgXdxQZUvgfHsQL5cm1Z/E1du1hcNWD/3SbfIWwWhFU3UfPKhatzs1sAF2
 onbbB3kWNei0ODau3hD0xosElgTH6h7DhUwCuCbg8n6SZ7MKM5bcafLCreXrzbrYfrZz
 Dei0leA3En9xKGlI338Enp/gzojbZwaxFQ4vP8rlCw32PRwwwv5A7BAs6BOHheLIEkKm
 cvhSBfNQVc7AlzRmVvK7XE1KEnvV25zy15ocV9v5PnBY6VnPxf0PKwCUqqqbwaalxfum
 zs1qjHSSqdzbYfel7NH8fzjZ01LTBcWWVz/Ph/aUtfYzCzxaPYXEPuyqUNH+NcL/IGw3 Mg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ppxj1acdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 09:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vof+glbxnzUSbaa8kmVErAyL042CQhXHyMhATgruBn1FkXHXlsH9CmRvkxmLEgqfuVdpHeVIWZBrdwjd+ITRR395GLoe77k1crqDxYs0QVicvm3TQGhzcK5AaI0EzfaPgGpSIoTuvY1NrVuM7zje2zA6Su579HAn9I5emKgjAoiSAkJDPKCTn2n0k09WujSzsLEh6V5OGcGdS1mo6fsGLRFgfUOB2wEctSeMJQ8WX6KMXT+rtelUtxE37AC8SYQparVyz1aZwE/kzslvsgD2lnmA1MhgUM82sshKZD//Ih8cd2v9UlgR0hde5rtHj7S8cJyhHVU/uqpiSS/jAgBisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpavtYJlvm6sIgR4vIaH/lmZPqa06T1tjxzYdETam0s=;
 b=AEAC66//thsS4PSxmGO2rhWHsoXcoNduTOqRTkVh0rnzjOnOBHPoIr8DG0ZlNuohKHqtLbwXmpFmIxLaGi1VHvrho5LS8/kkf7rZxJBXDs+nV+w+b5TxasJE1QdU7VtWixNa09iqa/kbOlkdjfnB0S60ypKka39mmRbI6uTc83MGCnMGANiuXz8pzrwfOXvTvMPmpJGC3gydjXSShSEWmGYNz/zUqOXDp2XCyumiXFA2gungJYhSoonkoqL2jH5Vxdn4xDmwYtndGa2psNN8atwji+Y1ZYKkoK6+HDLR6n5w5P3NeOjh4ir87aUh1kETTfc3JBpTGcAvVVAXPclUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by DM4PR15MB5455.namprd15.prod.outlook.com (2603:10b6:8:8a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:21:02 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::4746:c32d:b4d2:ad88]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::4746:c32d:b4d2:ad88%6]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:21:02 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>,
        "syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com" 
        <syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Thread-Topic: [EXTERNAL] [PATCH] RDMA/siw: remove namespace check from
 siw_netdev_event()
Thread-Index: AQHZZSF1a9Z1kZnw5kWDcJVsigp35a8ZUE0g
Date:   Mon, 3 Apr 2023 09:21:01 +0000
Message-ID: <SA0PR15MB391907A218BD2576E2C15A1299929@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <a44e9ac5-44e2-d575-9e30-02483cc7ffd1@I-love.SAKURA.ne.jp>
In-Reply-To: <a44e9ac5-44e2-d575-9e30-02483cc7ffd1@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|DM4PR15MB5455:EE_
x-ms-office365-filtering-correlation-id: 5328a34f-ded2-4532-8b79-08db3424be5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MmtOlKFSpCsKkU4ixNx1j9bLfiABGHabtHsD4wFJNBBbdK7HOik8ktDeRkIto/rkmCeDjJcxwyuAOcvg7z+lnlYVdmXosuNPed954vK8MdyZ4t5YCSgzMjfWJIyCvSgViWH+PiXCalQnP3yZs8+H7Td2GMTxQK/PvNK03UprjGXuA3+7GeP2+WEDe3hc7DCM4xAPhiurtxnTtxmZPycylwungnbvORxCVbu7ccfT0KX/effHlMt7rr12h4JUvFUPNihJFZFjp7XPsykcyNnHlfCiW0oGTbJBVQdTessYP2jb8YO9/sRo+1sNZMjWiin82KXtelwAkGev9iqOpOsbHZNVsZYEahDtF/ob2OPh7wh8YLQ9CeYw5lYKGVHzH+Asehcnsfpd2MKq/R02ubBQ+CQ7eXH70ABtxUoZdA6TmAb6Ih5IYAxvPOE7My1nz/PlIbvxQ5M+LtQlJbJ8CgLGgJCCtjHORfb2Y4bSVPf7p448eMDsniXt5ulmQlRS6KeX/tXCumkyXJhbNqmyT5fRESXy47Ci/F64AoKYvL/Ud80uo4ZbO73m7CnTMsdbSHDD/C1PxFj85g0wNanssy8e/hV7S9tLjUNVlZSGHAOLJ6LvSAUp9DcLDuBPuB4dR7LXBi+AYggtz29vpNDxKRzfkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199021)(55016003)(71200400001)(7696005)(2906002)(33656002)(41300700001)(4326008)(66446008)(64756008)(6506007)(186003)(66476007)(66556008)(66946007)(76116006)(8676002)(8936002)(5660300002)(52536014)(316002)(110136005)(54906003)(478600001)(966005)(83380400001)(9686003)(53546011)(38070700005)(122000001)(86362001)(38100700002)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlV0Szh4TkxhbXd1NlFQNm10RC9hYUgrejB3M0ZhbnlkZHVaYUpEWHhYajIv?=
 =?utf-8?B?aE41bCtZT1FuRGRoZTVnTkhzQ1JIRGkxcEFwMGx3bHk3SlNzUFowZ1Y1VXdT?=
 =?utf-8?B?V1l3OTRDbmh5QzkwYWd5dkpqaHNMWmV2aDBjM1hETkdwNnlqenA4OXVpQWZY?=
 =?utf-8?B?cjVPS0NnUVphbXcyU2ZwOEc2SWgxa0FRQ29PdXRXQjdiRkpaeGZBNHZDc2dp?=
 =?utf-8?B?SjZGOUZSTWFWQ25yRjlBcDhHZEVTWUNLbjVDcnJLV2xzY3lnVHZTdjIrQmlt?=
 =?utf-8?B?M2xQeS81d2ZIbzN0SVhPUTQvNTkvRWIwVnUwQ0FSYVVWRjZLNXFQTG16Tk9U?=
 =?utf-8?B?b05sN3dFWElRbFR6V0Zxdi9HOGQyWmVjeFBCbXQraEl2TWUxRDQ0VlA5UkRn?=
 =?utf-8?B?cG9CMWgwZ0EvN0lvV0owK3dCL055aFhUWi91NHAvck91bWlTQi9VczRtSGxj?=
 =?utf-8?B?NG4vN3RlekF3UGM3eHVmZkxtVlVjODZGYzRLU213UXB2VDQ3UTJmeFhFN0hp?=
 =?utf-8?B?Sm9kdWlUZUdXNHZZZjZMdkdFQ3pVU2Q4bEwzSVR3U0J3djhLOTRNSjFNMHFT?=
 =?utf-8?B?QS96czBnY0JmK2pMeFZEUnJ1OW9UdmR2RUViQlhVaHRIaWdBcklqMzhJVENn?=
 =?utf-8?B?Wm5kYncvODFNT3hCVUZHZzlNalBCTEhyYzRFbTN2MWxFM000N1VZU2NxU1F2?=
 =?utf-8?B?Zm5uRytWZW9yOFdBbjcyNWJ1MDQvcUtQajhQWWNtajV1dy9XVXlXVDlBWkx2?=
 =?utf-8?B?SFNHcXRBMDd2L3Rwd2pVRkJZU0x6THpOalBRekFQS1dob3YvQTk4R2hsNGZG?=
 =?utf-8?B?MXMzV0IreXYxZkYyTG1WS3czTTlJMmFvZ0FMNTBKRkY0dXpINkVFNmVjKytK?=
 =?utf-8?B?R2dWVkQwRENaR3V2SUFsbW9QNC80K1ZnMzU4NkplWG1jNi94eTJoMlRvWWgx?=
 =?utf-8?B?NWpBM3JYc1ZCcDYrV3J1VHM4LzVXd1lEV3BMbG9WRlJ4cTY2MFhXRXA2MXBx?=
 =?utf-8?B?VUd1Zm5CSEF5NUtzZEFlaUFpU1JzU1Bmc2kyeEE2Uk9JVnprc0JKbk1zVlEr?=
 =?utf-8?B?Y3BCT3RVb2tVb0pUTzQxaWZodkF1cDhsZWdjcUFwUmEzODYyeTlDOE8vRDBN?=
 =?utf-8?B?VDNPN1phOGZuZnExaDhRTU0yVkR3bkFIeHFQUW5KdEUrRUFPWnlHWnVDazZ3?=
 =?utf-8?B?UzRiY2hjdDVDS1V1KzRGVWRkSWFXSUJXWkFoMXRyTGdOVEpnQWw0eDNCeENQ?=
 =?utf-8?B?Z0tZZURMeXVDUVFXK2xtcXBhRFJiTkYyeTFIelQ4akFvVnQ1VmZhUFlZd2lj?=
 =?utf-8?B?OStIMTc4NHR6Yk1FK09EVSt3RXZqbTM5WnA2dy81TTN0SGVpZHFDbGpLWnBO?=
 =?utf-8?B?NUttZ1pIQzVlald5VjZqeFVJNnY0UGhTUkRGY0k1L0RXY2Z0SDRya3gxaGsx?=
 =?utf-8?B?TzBtcG1NZlVtMTZWM2FSMU9aTTlRSkhkYllOa1FRZ1RsNFZnWnJ2WHVXaTND?=
 =?utf-8?B?T2RwTzJWUlRwS0pTRzRZaHA5SUY1b0ZGN1Z4SHlYVmRCSVBUWm5hNTIzb1Qr?=
 =?utf-8?B?Tm16M2xLRVQ3bjc5NXZUUkZ2RndnNWljRlBkWEs5YXk2ZTZNYXBnZGx3N1J4?=
 =?utf-8?B?V3pCdXQwbk9tdzc3bTZCeTBHY1NFKyt4R25iM3hSRUpjNHh0Yk0vNVN3bzBK?=
 =?utf-8?B?c2JMQXZQNHpwNmErSDQ2ZDVBVVZZemM2bVNhdytMYUZISWpreXhWUGRzZVJ2?=
 =?utf-8?B?RDFKeGFFTFp3ZVF2dlBoSDlWcml3VXFMOS9QczJSZXBHYWFDb3FUODlpMlly?=
 =?utf-8?B?RklpbDd6R1VJNGxHOEkyRTB6QjFUd2xCb1BJZXRoVlJTMk1wdzVzRlFCV0hR?=
 =?utf-8?B?WTQzVlgxczZTRXRtcUJhbFZITHY2SVdrY2hJc1F6MWtGVUxRT2xXSEpLQ1ZW?=
 =?utf-8?B?Uk56VXpYNzRxTTFuRDFpNmVlMFVjcS9pM1QrS0xXbVpmK2FlWjJXTU42OUxL?=
 =?utf-8?B?YkJ6aEl1c1RoaUk1U3piL3YwN2ZGSFJUeUVRcExZZ0hoY2FVSDZBUmNrL25B?=
 =?utf-8?B?dkZRSlV2MkJOMWw5YVVLSUxYL2xFRDZ1UHNWek50dk80SDVES295MU5rd0F5?=
 =?utf-8?B?OW1SNmw5SlRDVHNaazFSQ0EyYVJ1Yit0bTFRa2NlSjdGaHk4dDFmYUpTb2RU?=
 =?utf-8?Q?6vbYFbXQt9FtGE62fro3VAU=3D?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5328a34f-ded2-4532-8b79-08db3424be5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 09:21:01.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWPpJBYgPQ0b9RcBxaIW9/eutTDSNmkGVCni/hqIOCf5r9SAC1fD700q2kBKUDznr4+4pSalNyCq0F07o5tvxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5455
X-Proofpoint-ORIG-GUID: TWVrv5TG6uBRdiV9IO2akKZnG3zJK_xY
X-Proofpoint-GUID: TWVrv5TG6uBRdiV9IO2akKZnG3zJK_xY
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
Subject: RE:  [PATCH] RDMA/siw: remove namespace check from siw_netdev_event()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_05,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=862 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030070
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGV0c3VvIEhhbmRhIDxw
ZW5ndWluLWtlcm5lbEBJLWxvdmUuU0FLVVJBLm5lLmpwPg0KPiBTZW50OiBTdW5kYXksIDIgQXBy
aWwgMjAyMyAwNzoxMA0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+
OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT47DQo+IExlb24gUm9tYW5vdnNreSA8bGVv
bkBrZXJuZWwub3JnPg0KPiBDYzogT0ZFRCBtYWlsaW5nIGxpc3QgPGxpbnV4LXJkbWFAdmdlci5r
ZXJuZWwub3JnPjsNCj4gc3l6Ym90KzVlNzBkMDFlZTg5ODVhZTYyYTNiQHN5emthbGxlci5hcHBz
cG90bWFpbC5jb207IHN5emthbGxlci1idWdzDQo+IDxzeXprYWxsZXItYnVnc0Bnb29nbGVncm91
cHMuY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSF0gUkRNQS9zaXc6IHJlbW92ZSBu
YW1lc3BhY2UgY2hlY2sgZnJvbQ0KPiBzaXdfbmV0ZGV2X2V2ZW50KCkNCj4gDQo+IHN5emJvdCBp
cyByZXBvcnRpbmcgdGhhdCBzaXdfbmV0ZGV2X2V2ZW50KE5FVERFVl9VTlJFR0lTVEVSKSBjYW5u
b3QgZGVzdHJveQ0KPiBzaXdfZGV2aWNlIGNyZWF0ZWQgYWZ0ZXIgdW5zaGFyZShDTE9ORV9ORVdO
RVQpIGR1ZSB0byBuZXQgbmFtZXNwYWNlIGNoZWNrLg0KPiBJdCBzZWVtcyB0aGF0IHRoaXMgY2hl
Y2sgd2FzIGJ5IGVycm9yIHRoZXJlIGFuZCBzaG91bGQgYmUgcmVtb3ZlZC4NCj4gDQo+IFJlcG9y
dGVkLWJ5OiBzeXpib3QgPHN5emJvdCs1ZTcwZDAxZWU4OTg1YWU2MmEzYkBzeXprYWxsZXIuYXBw
c3BvdG1haWwuY29tPg0KPiBMaW5rOiBJTlZBTElEIFVSSSBSRU1PVkVEDQo+IDNBX19zeXprYWxs
ZXIuYXBwc3BvdC5jb21fYnVnLTNGZXh0aWQtDQo+IDNENWU3MGQwMWVlODk4NWFlNjJhM2ImZD1E
d0lDYVEmYz1qZl9pYVNIdkpPYlRieC1zaUExWk9nJnI9MlRhWVhRMFQtDQo+IHI4Wk8xUFAxYWxO
d1VfUUpjUlJMZm1ZVEFnZDNRQ3ZxU2MmbT1WcThpYzVzbVprNGMzMEQzLWY3bWVaal9uSVpQLQ0K
PiBKczBTalpMcXp5aDVVVDRjWFZPVHVsa1ZoQjBTRk1WamRWMyZzPXZvVXhMT0M0alpRaThkaVB0
ckVVM3FVV0tKRHFfdzJkLQ0KPiBkV0xES2QwblVvJmU9DQo+IFN1Z2dlc3RlZC1ieTogSmFzb24g
R3VudGhvcnBlIDxqZ2dAemllcGUuY2E+DQo+IFN1Z2dlc3RlZC1ieTogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IEZpeGVzOiBiZGNmMjZiZjliM2EgKCJyZG1hL3NpdzogbmV0
d29yayBhbmQgUkRNQSBjb3JlIGludGVyZmFjZSIpDQo+IFNpZ25lZC1vZmYtYnk6IFRldHN1byBI
YW5kYSA8cGVuZ3Vpbi1rZXJuZWxASS1sb3ZlLlNBS1VSQS5uZS5qcD4NCj4gLS0tDQo+ICBkcml2
ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMgfCAzIC0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXdfbWFpbi5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWFp
bi5jDQo+IGluZGV4IGRhY2MxNzQ2MDRiZi4uNjViNWNkYTU0NTdiIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMNCj4gKysrIGIvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3Npdy9zaXdfbWFpbi5jDQo+IEBAIC00MzcsOSArNDM3LDYgQEAgc3RhdGljIGlu
dCBzaXdfbmV0ZGV2X2V2ZW50KHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsDQo+IHVuc2lnbmVk
IGxvbmcgZXZlbnQsDQo+IA0KPiAgCWRldl9kYmcoJm5ldGRldi0+ZGV2LCAic2l3OiBldmVudCAl
bHVcbiIsIGV2ZW50KTsNCj4gDQo+IC0JaWYgKGRldl9uZXQobmV0ZGV2KSAhPSAmaW5pdF9uZXQp
DQo+IC0JCXJldHVybiBOT1RJRllfT0s7DQo+IC0NCj4gIAliYXNlX2RldiA9IGliX2RldmljZV9n
ZXRfYnlfbmV0ZGV2KG5ldGRldiwgUkRNQV9EUklWRVJfU0lXKTsNCj4gIAlpZiAoIWJhc2VfZGV2
KQ0KPiAgCQlyZXR1cm4gTk9USUZZX09LOw0KPiAtLQ0KPiAyLjE4LjQNCg0KVGhhbmtzIFRldHN1
by4gWWVzLCB0aGF0IG5hbWVzcGFjZSBjaGVjayBpcyB1c2VsZXNzLg0KDQpSZXZpZXdlZC1ieTog
QmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQoNCg0K
