Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078B97D9887
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 14:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbjJ0Mka (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 08:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345658AbjJ0Mk2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 08:40:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1F610A
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 05:40:25 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RCMsqg028957;
        Fri, 27 Oct 2023 12:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PEGy0SFsoWVuDPxHwFpGWL2sTpS4LFMXLQQ22LZ+DaQ=;
 b=CuiuhR55Q1T52H/CbL0fhd8SrUCyUmY4VKVsLLq0N9YNLy7g42ZJDrHHGNspaSKcHnWe
 Z1OnxjXXHW3ViW+/SXrWGI00toyC1m/gejLRtFL4mwUfzSeyj+mO/ExWW5rSVXbgllS3
 DECuj64wXMc/xDV6G8iIu7VrWTMuUOioI/fuS4q4+yj+MHz1ZfLuVBUCFbVRpXhUEKbm
 aN+FlQzgsyx2EKrG99Cw6dVSnmIHmD/PYT7HGo96lBRzBzfH7Tcwok7adUBNhC1rPETa
 CMF07Oh72CgJBb9MJc5C/f1eKFMLBIcLm4LEZuCW5om4Ua0liIamqVqr8nf1CTlKvbFK Eg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0d5f8n4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 12:39:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAgO73o0nLOuvDQkGRm02XiE0Sl0Ti4KuK1LqLM6LduYQdYUnOUVZg4YMx8yYQiSY2j73Zb5aEzAUDPCsdRqxhT4+Pzzn4lw7PA0HMEcXQHQrydLyWyIAbZzreP9jd0rVedvxrYhnEjsvYB1ycEiQ4bgUEJbsP4Y9zbV4ipZv72Oo0C5XORywAqp31mzEMX3fvoQDjq+3LISyfuhg+nATDRNpTsNu1nhElzbT7xq0CqnZiSFvxHKIwL/0UXRUx/9IlNY6ugNWgk41n7NdWNz5UgDj8EeRgjggtPy8vLZ/xh7TwMf7mEFjZ9gcwEEEtzwcuQUQg6QVrFe5KVirZRHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEGy0SFsoWVuDPxHwFpGWL2sTpS4LFMXLQQ22LZ+DaQ=;
 b=At45xPlq7Z96vFL+z1tGaFITjJz+iXnyiKFkOHVZhSXCQO4N2r2WRImpRFYZSQUP+IlLc0skdOxjOL6nxpSfW8WobABNb37wSVpwuuToDh8SlD6XTnNWom0nnkn1b6sZ6Y0oaYRxt8DsxuuK23iACG+T1GY8+YlvKPA95LxjlcX/QE07EAgHh8dSGXik1kWCqviAGAxccc9kxaVOcjRQHc7u8YaOCnR72VGpfds0qu+HqQDuMEJYYgi9za/M42sl9GqpJHrfmIUasjL0PQ+4pnuBlB6LA/cYkEGhJhQPwvvLMt2QYRxiYyYC5CtZR5fIiahKSJgYwHobMf8ZX9zKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by CH3PR15MB6117.namprd15.prod.outlook.com (2603:10b6:610:15c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 27 Oct
 2023 12:39:24 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 12:39:24 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V3 14/18] RDMA/siw: Remove siw_sk_save_upcalls
Thread-Topic: [PATCH V3 14/18] RDMA/siw: Remove siw_sk_save_upcalls
Thread-Index: AQHaCNKdQ7YsB3B2E0CwPti26FGZFw==
Date:   Fri, 27 Oct 2023 12:39:24 +0000
Message-ID: <SN7PR15MB5755369505DCCDD6A9BABAC899DCA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231027023328.30347-1-guoqing.jiang@linux.dev>
 <20231027023328.30347-15-guoqing.jiang@linux.dev>
In-Reply-To: <20231027023328.30347-15-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|CH3PR15MB6117:EE_
x-ms-office365-filtering-correlation-id: c6dc2951-6354-4434-46bd-08dbd6e9c05e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G53e0gQDBrJtymt9RtAprSDRN8vZrjdQb2xRy3R7ks+K1IKK9x00Lq+VCCUhVU39zfzi6PW8L2qr6hkNM/MC2C+NZuEL78twXvLVaUnVFt5WH+cCGA4Fa5MyRvpAjb+GY1ANwKc3xLY1SR8eZ53JQFYuk8Gm+f3TLhU/EMxiUYMwD1wMAyiaMRZibbXZXmVrkM5s/ukcTKLyFKtEQrLT1RONvslhNrNcKm1tUrDD6R4J0RBAno4+mRCpbp14a9NwIYOElluMZ/V9Jqh0ql7/ZQ3P4Pk4bJTuJeLUYFw75sDLf5H3f6DEqIJfJCqeKTETPDoAUV9MLFdgytcVbLxNRc7VpTPZ5wm3WaoQwypNHf3x5ubBP69ERMnoEZZAWIGc0fxoafBkOPOlhjV/U9C4FvziC+9U5i9KARRnPfGo3b/+gyVP7FgfDdHrinn/s/rnBoCuV0rWSCSvbXAez4nnb2lfuycHfyJX+tHxHbIZEzGTL52VmRh/f3od5LfEjtJ88WD6t+17VdjvfvZfPzeeIjUU/cvpFF4xpVBEVuFsscqD3VX8pkO6uMZahZvAZwxdgbciHWq3qdp7nM9DiAzQjZOSNuLKR4RFEd2h5QuMIXDLqVUzVYvG51qXCT33tDWEr2WCRduVezemEyDYtRRDau5x2pCKg0IVewDjHuxT+1s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799009)(186009)(4326008)(8936002)(64756008)(8676002)(66946007)(66476007)(316002)(110136005)(41300700001)(66556008)(66446008)(83380400001)(76116006)(9686003)(2906002)(7696005)(53546011)(6506007)(71200400001)(5660300002)(52536014)(478600001)(33656002)(38100700002)(38070700009)(122000001)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0t4andadUc2MGpOcFlRbmdVSzV0b3ZpQVdtRThhZFlqSm5rMnYzc1lxSlBa?=
 =?utf-8?B?L1dKanVBQzQ0R2FsYkJCOGZaMjdpZlhzWHVyYTVNWDJ0b1NDRDVhUWFqazNj?=
 =?utf-8?B?Z2pOTzh3WC9SbXJqRHpZb0U3MDVWTXdrMlltcCtRRnpMUVNLbk9QWGNnWWM1?=
 =?utf-8?B?azlELzIybzBHMjRpblppcXptSGY5VDRDQzU0VHVpTDU3NHE3ZVFHeXI5Ykp0?=
 =?utf-8?B?aTF1U2loNWp1QnBuNy8xdnlyK3NtbE1BRTV1WGVmRFg1VElyVXVQRjhUZkhR?=
 =?utf-8?B?R0lTalBrYm00Mk5GR01HNi9XeTUweFE1Vm4zVUxld2NlaTliVlVvWkgrMUly?=
 =?utf-8?B?Rmh1WkpJNGV3UldiaTZtNDA4YTBjWmZ2cnNMMU56ZXppdDdjeEFPTkF5bDBz?=
 =?utf-8?B?Y3dLY0MvNVZ3cjVqS29aQjRwTkFTZnFUOHMvMzJLUlRjeXo3SDdKYmxpTExw?=
 =?utf-8?B?OHo5RVBmVTVhekpUclZnbW9ObnVFakljVnV4bmpFbWhPMUgwNC9tcCtIRUk4?=
 =?utf-8?B?V0ZFRURxL1M5RFJxNzVPYkFndDNScjIwVXloSENCNUlZSU1mZG5EeXRzU014?=
 =?utf-8?B?T0NqY0JoWlExZGlBZjc4VkU2aDNUMmxhZmNHb0FrS1N5cVVBeWw1UmNOalJs?=
 =?utf-8?B?c2FrMFBTN3FnK3E0UEhkbzAvNjQ5ejk2L2pCcW1HM1hXelpwZUFhUDIzS2xE?=
 =?utf-8?B?dnR2SlV1VXpjU05VQ21ib1MrbkQwaVpLSFRLNENEM2lDVnMyR1hzTDNxWHJh?=
 =?utf-8?B?M3JTdlE2SnY2VDltcHlIcm9jaFB0YjNrQUhaN0FJOThxR1paUEVmTVVBbEdm?=
 =?utf-8?B?ZlNIck54NjJ3clI4WlNmZ2ZLTUxpS0EzTVF4bzAzVTFST1pwMkRYMHVpL0Vi?=
 =?utf-8?B?S1k0SFFPWkczU25yVitUdFpIbkQrTFpBMkJPeWMxVXZ0dU9VV3laM0tMNnA5?=
 =?utf-8?B?NTNyTWFSSWN0eE9qSDZkU0FNQlhHTGNjamFuY28remZ6SEZCMC9SMkhmeHNT?=
 =?utf-8?B?S2N0WXVsMTNkME0yVHBKNWdlNzYyU0ovTlJDWHBIMmw4T2E4YWhuYWZZUDQ5?=
 =?utf-8?B?SXhWcEp1VnkzOUlhRzBST0hrYVZQeU1uT2pvbWMxbklvVTdGajhTZTM4VlpU?=
 =?utf-8?B?dU42UmdQekRqKzBZakk0aVdhUG9ybzZTdEpFcG1ML2dMeCtXVXBlZmsvbTZy?=
 =?utf-8?B?TjNteXlmeW1Qc2wyTC9rdzZmczZzOGV1K3RmWW53TkV4SUEvZW1tVDJWcVgw?=
 =?utf-8?B?eUkxZHFBWS91YTdldlc3OHlBL3VBb0laRDcrVnQycXdsUFd3ZG4zN0lxajNs?=
 =?utf-8?B?ekdaMFhCRmIwQUZHUncrM3I5L2pJLzFheEFhT1dpSXVZdmhYc2pmOG1DUkVj?=
 =?utf-8?B?SEEydC9QbGNBemphUXFmS28ybHZKa01qTmJxYVAzRC9BcDFlbUs5enNQakxI?=
 =?utf-8?B?Rk0xcEpRUURtR2tEZ3RMUmw1RndLSi90dzNhNkNOaHJDUGZVTEMrUzRqSExw?=
 =?utf-8?B?RjNSSVAwV0k5SjA5UkFxSkxVMGV6UkRpT2ZLb1dndEFvTURIUmdiWm9rbHow?=
 =?utf-8?B?M2lvREdKRGRYdm5UL0dNQ2QzblNzeENweVdYZi9qbzZuUXJXMXczdk1SWnN0?=
 =?utf-8?B?ZVdnSG5GREg3bUY4RGR3WlVpaDVNWGdPU3hJYlY4cWhvYVc2N0o0N1ZJeVBi?=
 =?utf-8?B?b21jOHhhYTROUXFKenR1a1pQTHg2MnRBeHZMdVJIV0pYRnozNG9sWFpZU3cv?=
 =?utf-8?B?dlJmWEdWY1pKVERiQ3A0cDR2WDZSYUVZMnNzeVo2QloxanJLTll0aURUNkdt?=
 =?utf-8?B?cERuTkNQR0RyZHc4NjVCNGlOQTAyVHF5eXlFR1Y1UmhwRmlaaWEwVTQ2Znk4?=
 =?utf-8?B?d1ZIQ0FmY0E3S1Y2cFV6emVnajNLT0x2TldCOUl0UEJkWmx3dFRoeVpaclZL?=
 =?utf-8?B?UDIvMUNWMFhEUUhJTDFSNUNJSndmeUtpOWdlT0cvZk8rZzV6RXRPekxVYmhI?=
 =?utf-8?B?cG9rVXRMcExydWZlWnEyU2dLczRFQmlVSDIyUzJyQXJndVk2T0w1SCtrRm5N?=
 =?utf-8?B?R21URVBjZmpkUlhkbTFUZ3FQWlJydG8wUEtIL3MyRSswMWgxU0Y5a0ZIMzFG?=
 =?utf-8?B?aG50NjRBK0JpVTFnaVM3NE1weGVBY1BwSmdvaTZ6S2RjV2xhbm1jQVpCRVRi?=
 =?utf-8?Q?jtDChl+8Xi4LupHoChF6P1cglUw8YfDnmT30Kw7netvN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dc2951-6354-4434-46bd-08dbd6e9c05e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 12:39:24.5696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9dH2a9YPu9wzPT28HO0FpZwRFmiTJ/yzrQKeBtmwp8vhSyhHHfRNUEAWSaUsILUBfZN9yWI1y/GfjmmzJGeSLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6117
X-Proofpoint-GUID: 58jhsY3PtdR3aawvLrJPbtcCj3z3eUm1
X-Proofpoint-ORIG-GUID: 58jhsY3PtdR3aawvLrJPbtcCj3z3eUm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=977
 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270109
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
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNywgMjAy
MyA0OjMzIEFNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWMyAxNC8xOF0gUkRNQS9zaXc6IFJl
bW92ZSBzaXdfc2tfc2F2ZV91cGNhbGxzDQo+IA0KPiBMZXQncyBtb3ZlIHRoZSBmdW5jdGlvbmFs
aXR5IG9mIGl0IGludG8gc2l3X3NrX2Fzc2lnbl9jbV91cGNhbGxzLA0KPiB0aGVuIHdlIG9ubHkg
bmVlZCB0byBnZXQgc2tfY2FsbGJhY2tfbG9jayBvbmNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
R3VvcWluZyBKaWFuZyA8Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYyB8IDE2ICsrKysrLS0tLS0tLS0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+IGluZGV4IGNmZjBmZDdjZWVlNi4uNDg2NmI1
M2IxNWMzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5j
DQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gQEAgLTQwLDE2
ICs0MCw2IEBAIHN0YXRpYyBpbnQgc2l3X2NtX3VwY2FsbChzdHJ1Y3Qgc2l3X2NlcCAqY2VwLCBl
bnVtDQo+IGl3X2NtX2V2ZW50X3R5cGUgcmVhc29uLA0KPiAgCQkJIGludCBzdGF0dXMpOw0KPiAN
Cj4gIHN0YXRpYyB2b2lkIHNpd19za19hc3NpZ25fY21fdXBjYWxscyhzdHJ1Y3Qgc29jayAqc2sp
DQo+IC17DQo+IC0Jd3JpdGVfbG9ja19iaCgmc2stPnNrX2NhbGxiYWNrX2xvY2spOw0KPiAtCXNr
LT5za19zdGF0ZV9jaGFuZ2UgPSBzaXdfY21fbGxwX3N0YXRlX2NoYW5nZTsNCj4gLQlzay0+c2tf
ZGF0YV9yZWFkeSA9IHNpd19jbV9sbHBfZGF0YV9yZWFkeTsNCj4gLQlzay0+c2tfd3JpdGVfc3Bh
Y2UgPSBzaXdfY21fbGxwX3dyaXRlX3NwYWNlOw0KPiAtCXNrLT5za19lcnJvcl9yZXBvcnQgPSBz
aXdfY21fbGxwX2Vycm9yX3JlcG9ydDsNCj4gLQl3cml0ZV91bmxvY2tfYmgoJnNrLT5za19jYWxs
YmFja19sb2NrKTsNCj4gLX0NCj4gLQ0KPiAtc3RhdGljIHZvaWQgc2l3X3NrX3NhdmVfdXBjYWxs
cyhzdHJ1Y3Qgc29jayAqc2spDQo+ICB7DQo+ICAJc3RydWN0IHNpd19jZXAgKmNlcCA9IHNrX3Rv
X2NlcChzayk7DQo+IA0KPiBAQCAtNTgsNiArNDgsMTEgQEAgc3RhdGljIHZvaWQgc2l3X3NrX3Nh
dmVfdXBjYWxscyhzdHJ1Y3Qgc29jayAqc2spDQo+ICAJY2VwLT5za19kYXRhX3JlYWR5ID0gc2st
PnNrX2RhdGFfcmVhZHk7DQo+ICAJY2VwLT5za193cml0ZV9zcGFjZSA9IHNrLT5za193cml0ZV9z
cGFjZTsNCj4gIAljZXAtPnNrX2Vycm9yX3JlcG9ydCA9IHNrLT5za19lcnJvcl9yZXBvcnQ7DQo+
ICsNCj4gKwlzay0+c2tfc3RhdGVfY2hhbmdlID0gc2l3X2NtX2xscF9zdGF0ZV9jaGFuZ2U7DQo+
ICsJc2stPnNrX2RhdGFfcmVhZHkgPSBzaXdfY21fbGxwX2RhdGFfcmVhZHk7DQo+ICsJc2stPnNr
X3dyaXRlX3NwYWNlID0gc2l3X2NtX2xscF93cml0ZV9zcGFjZTsNCj4gKwlzay0+c2tfZXJyb3Jf
cmVwb3J0ID0gc2l3X2NtX2xscF9lcnJvcl9yZXBvcnQ7DQo+ICAJd3JpdGVfdW5sb2NrX2JoKCZz
ay0+c2tfY2FsbGJhY2tfbG9jayk7DQo+ICB9DQo+IA0KPiBAQCAtMTU2LDcgKzE1MSw2IEBAIHN0
YXRpYyB2b2lkIHNpd19jZXBfc29ja2V0X2Fzc29jKHN0cnVjdCBzaXdfY2VwICpjZXAsDQo+IHN0
cnVjdCBzb2NrZXQgKnMpDQo+ICAJc2l3X2NlcF9nZXQoY2VwKTsNCj4gIAlzLT5zay0+c2tfdXNl
cl9kYXRhID0gY2VwOw0KPiANCj4gLQlzaXdfc2tfc2F2ZV91cGNhbGxzKHMtPnNrKTsNCj4gIAlz
aXdfc2tfYXNzaWduX2NtX3VwY2FsbHMocy0+c2spOw0KPiAgfQ0KPiANCj4gLS0NCj4gMi4zNS4z
DQoNCkxvb2tzIGdvb2QuDQoNCkFja2VkLWJ5OiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2gu
aWJtLmNvbT4NCg==
