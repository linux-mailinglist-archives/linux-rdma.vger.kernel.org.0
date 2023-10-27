Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4637D9890
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 14:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbjJ0MlR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 08:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345658AbjJ0MlP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 08:41:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DC218A
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 05:41:13 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RCbq1a016883;
        Fri, 27 Oct 2023 12:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=t2HCs+ESRhfFXv8Zcfa0pbY7UIWYu9joJbA5hmG/EfI=;
 b=coFDWmaaPG6xDOe0ze83VNaOM3gRkUe2O3CH/KGq7YFKGYMCi5ifrXxHR5G2M4KjZSMe
 LL1ZxTWV81Rlpb41XLRQoyOS47poFEjzoG2lEBewa72Sok8qGdhCzi1+9aFNJyVm/ZN9
 cPrabF8waJ/PqJsyGz22eBKFIYZjRJJ+LHhv3NzAP3biEYfNrHX+/aDkfJarLE+pksts
 rM4uXBQ7+gbL/q2mlmcd/G2azObC5CD9NLi4wyBWDSzx7c4IusEPUimGfe3XRI7PSTk2
 DqTAm4tljBLAXGZpIvIpYzY/UF0TFfqdje3O2t9SAHnvmUm9JdYqNZpD0IOFBomW54i8 Fg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0dcf03bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 12:40:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhxrT0y2i6osQwjAta0lJMIIiAiW8Nh0abpZT6lFRFJY7VS0EbhT+Opn6Vk5q0nAaxgXQ+0X9JlsMXuSe4FKJNH+htiRwWlJNGvDSemi355hJ6XP46cY1VAWJuBUtEN1rYe0oZoZLzGyedwbdYFj95C39WM9LJjgKaG9o01dmzY0exCj+5X72M+h4nV/Tn43RzyMsWUKBOMz7VfLlGas9OHHMxbynDRTIFiuMmKOwrNlGnpXGSBabhkCWq1KbBWj8rJHZW02T/kAtd572TR+zwhjVtBgoBq1BDk8r3AIzUIebc2VOvWVa6tVyILno15zZYVgG8Nf8L9CyWNj/IQilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2HCs+ESRhfFXv8Zcfa0pbY7UIWYu9joJbA5hmG/EfI=;
 b=IzbNTYcoKT5LCkrv9q7im4yiOhnOQsDreHbihBhb8O6y2KlEH4WclXwcUmOqLMQHK/3hkdNHp02uwGnBJnAMhFjTo5F3kEg6azIFQ/mk2FezBUWl+YupTxbkAF+/ToQRu/R/wD5WWNf7q/LfbsbkWqLFLnug8yDuszIOvvVtoD30tMHFHImr+4jOY44qKS3iRgICMh2PELNGQzsoR/qkYqqRZnOwnzD4ryxMLPTdp0gl5buvxm7u4x3C4yLhHxTaJn4AxCPQiYXz+1/30x0YxdZALFLPqSnA0fltpCBTa5C0zV+DnWZpvXVfw4b8Hr33S182J8MEmtZMkZzBEMLcxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by CH3PR15MB6117.namprd15.prod.outlook.com (2603:10b6:610:15c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 27 Oct
 2023 12:40:44 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 12:40:44 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V3 10/18] RDMA/siw: Add one parameter to
 siw_destroy_cpulist
Thread-Topic: [PATCH V3 10/18] RDMA/siw: Add one parameter to
 siw_destroy_cpulist
Thread-Index: AQHaCNLN1Bi/rm9dSUeJVx6HHufeuQ==
Date:   Fri, 27 Oct 2023 12:40:44 +0000
Message-ID: <SN7PR15MB57554E13C9BB589A9F56C31D99DCA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231027023328.30347-1-guoqing.jiang@linux.dev>
 <20231027023328.30347-11-guoqing.jiang@linux.dev>
In-Reply-To: <20231027023328.30347-11-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|CH3PR15MB6117:EE_
x-ms-office365-filtering-correlation-id: f26eed8d-da11-488e-3133-08dbd6e9efec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4WyE/ahOOKFT4CHiVaf3AyOvd+SJ5WB4B4YRR711y7lL9hRS84nPuphJdXllwlBP+gifsOTXfCr39R5BHR+/4o3sxaCInTEC4EZGMIOp4H5ffCH7Sd9cVfExrtPxLbX6Ehr4RcfngFMH6g3lR/hNxQYgyIPdrkrExRvVNp2UG5fJhIDvoNowRZswXODl/ynLX+3Mm51xTqLt+FM/qK2+gNr1KXIWJOvgRLjQOT4042EpQ0Odq3v9OLNGv+aK4uedBMh3ZCsLxqu/ViSBMuqwukgW6LQs8lQRbrVeee2EluLgEwJq09GRh5s5Y3+zhVh3AmqsiBbcsVe56aUehRnvTRDytpNPtmLOK55qT1RVZPc8rHcfRqxzPIzSu/WUBTj+iJg4ubWbkyBQajY3cQplwpmtFuhabSF2uMHFkfRdUs/9eSDlnnpkF6Gm+NXh4LJ4QVDJl1/1XDZpKYl8vXi53+ambQ2m9TRxnyK5rodZp7w6GpthUQa91xq/F3b4HGw0+lwNFRJerz4PabuOo3rXeC7+THwgg2CUh9YmQVkIEIgjD+7rUYJPlbPwDVSZmW+jegcNmdpqzNDcDvvm1RSvODWhLHXqYVc0VsTe4qstGHCT6O66yAZB60pzQWKK7ElVJsYSYds7csgyrdbt42sjnNG5sX70P8wOqJfLjcTLFRI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799009)(186009)(4326008)(8936002)(64756008)(8676002)(66946007)(66476007)(316002)(110136005)(41300700001)(66556008)(66446008)(83380400001)(76116006)(9686003)(2906002)(7696005)(53546011)(6506007)(71200400001)(5660300002)(52536014)(478600001)(33656002)(38100700002)(38070700009)(122000001)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTYvakN4ZVdQaXNJVmFxTSsvVVFGUHcyVVZGaXA0UUh3ODBUOHoxeXppZHBH?=
 =?utf-8?B?dmgxZE12a2RsTUZOaDNHQVJNK1E2MlQvMXYyalZRQitNUS9HNkh0K294U0Jl?=
 =?utf-8?B?NENkbGtEUnJmQWFIbktxcnVOdWV5T1o0V0syVUpUdnJ6MEtjRGFUWitvam43?=
 =?utf-8?B?NG1Rb3JaWXUwZUxqUkZycEVHWnFOOXpDT2J5NUpDMkh1cTBTcGJwSFM0QStE?=
 =?utf-8?B?Z1NEV0l3dEd6cWtoeDFvREE3bXUvMG5OWTkvSE1GLzR3dlZndlRXQ0VmUzZY?=
 =?utf-8?B?MkNLM2x5RHovQXVkNXcrQ2o5cUNZQjEvQVQ1Y1F0ZDlmcFJWbllDemZEamlo?=
 =?utf-8?B?bHNxVkJJM0FFYjR2eFlkNGpHU285ZFFxelR2aXNvVXNLL3JObVF6ZmplMzVK?=
 =?utf-8?B?UEhab3FTSGQ4UGVKVk9FZXdoWlBPTGtIajJqZytoMWVwaXFrcVdTUGxndXo4?=
 =?utf-8?B?V3VHYWFVcWprYmVmdXVJUUlYWm5mamlFdFhaUUNERjdWS29oSXFhUnNwZ0Qv?=
 =?utf-8?B?TExLWVQ2VnczSVR4Wno1d3EvODk1TDlULzFqdlJVSklUWnpweERJNnFLczQ0?=
 =?utf-8?B?TG4wenNOakEwcFB0RWtLZW1kMnhxYWtwTWZTWXpiRnd6c1dBRVZzSjBSY1c5?=
 =?utf-8?B?eGZnVXVUNld4TEZEOEExeDdLbG9Jemd5N1BGdzF0ZDlPRFhvNVBteXJLNzVY?=
 =?utf-8?B?aTE1MjFIU0t5anBxcVRjQ2RkQlhRb3VXQmZhN3lPYzFST0lTaUNCbDRiczZn?=
 =?utf-8?B?VlRLQzNYVVZENmM3L1VaamdYMDQ4RCt0TUsvelhYemFJb2ZXQitYOGVMdHVH?=
 =?utf-8?B?ZnFTRFBjMTV3RGRPWC9yMnh0TFRuUEZPQ1k4ckxzRUFhU3BHdzc4NHZNOFdT?=
 =?utf-8?B?eEVISUJJb3hQRnB3SjFnc2pjTlVXVUZ2REZlTG9NTkhSQ2doUnJVUmM1MXYz?=
 =?utf-8?B?YmVRR1dOZHRxbUlIR3hPYzFSL2pWWmtyUmxNem1wUFFSQlJPYUY3bERrVGZL?=
 =?utf-8?B?U0NvWWNuRG5MQ0JZdFZVS3VRL1JRZUlnRG1LUlRUNVI2dzF6YnlCeFFtaHg1?=
 =?utf-8?B?Q3ByQUxSWGxhN1pPU2Y3d2tHZUQ5bnZXbWF4aVJYQVZMTFB4MHhjTU8vN3Bs?=
 =?utf-8?B?Tjd1Mm5RNks2cXZDeERRSnoxbW9WRmNnVE5tOE9KMkFUdHgycTF2NjI0SVc3?=
 =?utf-8?B?MTR0blBveitCMllMV1pnam5CTjJmZjN5NW0vaGM2dW9IbzhIK1ExdmEza1lo?=
 =?utf-8?B?b1pSTWx6SGsxZ3I4SXB3ZmVrcEViUWhOWnNEK01UdE1lQzlnd3pTZlNYdmpG?=
 =?utf-8?B?dmpneXQ1a3E2dEZYWWFHdFpxS0FIaU5rK3N6a2dOMnpPbktLRHp5elM2eDdo?=
 =?utf-8?B?YkwyU3VpYktrNnF4WWxCU3g2bk93M1ZwWVpmRmk0VWdhZDcrTDFEOXRMRG5T?=
 =?utf-8?B?RmhIdk1EeUxJOEphVitPaXhlQzFod25IUEVPandNMGdjUDZiWWMyZTQ5SU42?=
 =?utf-8?B?bnlDU2RQdFZaVVJaWG9hNVVMMWRFUWl1M2tPb1B2c1FrcFlXeCtmbkQvVjhL?=
 =?utf-8?B?Mk5Wdysrd0F1V2lkQzJlRTBjNjBBVjFMUjhYY3JBVXZHL2dnSkRUR0lIbGlS?=
 =?utf-8?B?OVlhMGRRY1FEbWJOWThqS1dJL3NQZUFtOHBWaWVDVERzcHVydkZQTytJOWcr?=
 =?utf-8?B?ZnphWUVIMFJETFpKaXM5Y1RPWk1MVWVRc0lOWHA5UGhiek5kdk5YTFphcHYy?=
 =?utf-8?B?UnFYaXY1TU8rblFsOTNXWFpZYS9MVy9KaFFNeWQxMzRyWmtkYnNNUUJ6M1pG?=
 =?utf-8?B?a2kyTjdaOUtqNDRoSURkM0ZTYXJVemt3RmVjYTgrNXYzbnFRb2diWmZSMlZG?=
 =?utf-8?B?Yk9nVFNlRGs3STZnMFN6NG9tb3kwU0RGcnM2anh2M3hFSjZMTFM2MjF6Nm1X?=
 =?utf-8?B?dDVyT2RyS0JkWjNaaEI3VkVZbHNZekFLNGFSbGRsTVRtd2h2eTJjNEc1emJH?=
 =?utf-8?B?VUQyZGRVUjE0ZGFvTjZJNWNkaUg0alY3bEQvTTVGa1hKZFNYUWY1emtyVjdi?=
 =?utf-8?B?MlBCKzhhNTd6Vk83SldZWkI5dVVldzNTQS8rM29TWC95Q1R3Uit6RXRNSlVW?=
 =?utf-8?B?RStVYXcvN016K1hxVzdwa2tGaXF4YVRCSGg2c251YXB4bVl1R2tUamxwS1hs?=
 =?utf-8?Q?9ckeFnLbebTTO3GR/4uRzyWbHsX8s0RrTUa/egobAAmj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f26eed8d-da11-488e-3133-08dbd6e9efec
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 12:40:44.3771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvjkOyN2ediBre8ZsqTU0c/0TBSCNFY71P6OSxjgUmF8a37zEjGOgbeI3x3cByVrPdurherM3/IFq65/N+LQhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6117
X-Proofpoint-GUID: WCXXm7oE1evwYOx9err-5xYb6AcbH8w2
X-Proofpoint-ORIG-GUID: WCXXm7oE1evwYOx9err-5xYb6AcbH8w2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=979
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
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
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWMyAxMC8xOF0gUkRNQS9zaXc6IEFk
ZCBvbmUgcGFyYW1ldGVyIHRvDQo+IHNpd19kZXN0cm95X2NwdWxpc3QNCj4gDQo+IFdpdGggdGhh
dCB3ZSBjYW4gcmV1c2UgaXQgaW4gc2l3X2luaXRfY3B1bGlzdC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEd1b3FpbmcgSmlhbmcgPGd1b3FpbmcuamlhbmdAbGludXguZGV2Pg0KPiAtLS0NCj4gIGRy
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYyB8IDMwICsrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxNiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Np
d19tYWluLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMNCj4gaW5k
ZXggMWFiNjI5ODJkZjc0Li42MWFkOGNhM2QxYTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
c2l3L3Npd19tYWluLmMNCj4gQEAgLTEwOSw2ICsxMDksMTcgQEAgc3RhdGljIHN0cnVjdCB7DQo+
ICAJaW50IG51bV9ub2RlczsNCj4gIH0gc2l3X2NwdV9pbmZvOw0KPiANCj4gK3N0YXRpYyB2b2lk
IHNpd19kZXN0cm95X2NwdWxpc3QoaW50IG51bWJlcikNCj4gK3sNCj4gKwlpbnQgaSA9IDA7DQo+
ICsNCj4gKwl3aGlsZSAoaSA8IG51bWJlcikNCj4gKwkJa2ZyZWUoc2l3X2NwdV9pbmZvLnR4X3Zh
bGlkX2NwdXNbaSsrXSk7DQo+ICsNCj4gKwlrZnJlZShzaXdfY3B1X2luZm8udHhfdmFsaWRfY3B1
cyk7DQo+ICsJc2l3X2NwdV9pbmZvLnR4X3ZhbGlkX2NwdXMgPSBOVUxMOw0KPiArfQ0KPiArDQo+
ICBzdGF0aWMgaW50IHNpd19pbml0X2NwdWxpc3Qodm9pZCkNCj4gIHsNCj4gIAlpbnQgaSwgbnVt
X25vZGVzID0gbnJfbm9kZV9pZHM7DQo+IEBAIC0xMzgsMjQgKzE0OSwxMSBAQCBzdGF0aWMgaW50
IHNpd19pbml0X2NwdWxpc3Qodm9pZCkNCj4gDQo+ICBvdXRfZXJyOg0KPiAgCXNpd19jcHVfaW5m
by5udW1fbm9kZXMgPSAwOw0KPiAtCXdoaWxlICgtLWkgPj0gMCkNCj4gLQkJa2ZyZWUoc2l3X2Nw
dV9pbmZvLnR4X3ZhbGlkX2NwdXNbaV0pOw0KPiAtCWtmcmVlKHNpd19jcHVfaW5mby50eF92YWxp
ZF9jcHVzKTsNCj4gLQlzaXdfY3B1X2luZm8udHhfdmFsaWRfY3B1cyA9IE5VTEw7DQo+ICsJc2l3
X2Rlc3Ryb3lfY3B1bGlzdChpKTsNCj4gDQo+ICAJcmV0dXJuIC1FTk9NRU07DQo+ICB9DQo+IA0K
PiAtc3RhdGljIHZvaWQgc2l3X2Rlc3Ryb3lfY3B1bGlzdCh2b2lkKQ0KPiAtew0KPiAtCWludCBp
ID0gMDsNCj4gLQ0KPiAtCXdoaWxlIChpIDwgc2l3X2NwdV9pbmZvLm51bV9ub2RlcykNCj4gLQkJ
a2ZyZWUoc2l3X2NwdV9pbmZvLnR4X3ZhbGlkX2NwdXNbaSsrXSk7DQo+IC0NCj4gLQlrZnJlZShz
aXdfY3B1X2luZm8udHhfdmFsaWRfY3B1cyk7DQo+IC19DQo+IC0NCj4gIC8qDQo+ICAgKiBDaG9v
c2UgQ1BVIHdpdGggbGVhc3QgbnVtYmVyIG9mIGFjdGl2ZSBRUCdzIGZyb20gTlVNQSBub2RlIG9m
DQo+ICAgKiBUWCBpbnRlcmZhY2UuDQo+IEBAIC01NTgsNyArNTU2LDcgQEAgc3RhdGljIF9faW5p
dCBpbnQgc2l3X2luaXRfbW9kdWxlKHZvaWQpDQo+ICAJcHJfaW5mbygiU29mdElXQVJQIGF0dGFj
aCBmYWlsZWQuIEVycm9yOiAlZFxuIiwgcnYpOw0KPiANCj4gIAlzaXdfY21fZXhpdCgpOw0KPiAt
CXNpd19kZXN0cm95X2NwdWxpc3QoKTsNCj4gKwlzaXdfZGVzdHJveV9jcHVsaXN0KHNpd19jcHVf
aW5mby5udW1fbm9kZXMpOw0KPiANCj4gIAlyZXR1cm4gcnY7DQo+ICB9DQo+IEBAIC01NzMsNyAr
NTcxLDcgQEAgc3RhdGljIHZvaWQgX19leGl0IHNpd19leGl0X21vZHVsZSh2b2lkKQ0KPiANCj4g
IAlzaXdfY21fZXhpdCgpOw0KPiANCj4gLQlzaXdfZGVzdHJveV9jcHVsaXN0KCk7DQo+ICsJc2l3
X2Rlc3Ryb3lfY3B1bGlzdChzaXdfY3B1X2luZm8ubnVtX25vZGVzKTsNCj4gDQo+ICAJaWYgKHNp
d19jcnlwdG9fc2hhc2gpDQo+ICAJCWNyeXB0b19mcmVlX3NoYXNoKHNpd19jcnlwdG9fc2hhc2gp
Ow0KPiAtLQ0KPiAyLjM1LjMNCg0KDQpMb29rcyBnb29kLg0KDQpBY2tlZC1ieTogQmVybmFyZCBN
ZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo=
