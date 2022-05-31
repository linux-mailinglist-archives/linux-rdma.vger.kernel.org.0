Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB174539854
	for <lists+linux-rdma@lfdr.de>; Tue, 31 May 2022 22:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345922AbiEaUzp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 May 2022 16:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347892AbiEaUzg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 May 2022 16:55:36 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241509CF7A
        for <linux-rdma@vger.kernel.org>; Tue, 31 May 2022 13:55:33 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VKgSTw002813;
        Tue, 31 May 2022 20:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=+z1xCKUhzAsnQ7a4zKYo3A8CJl5AEnzVe1QtvUF1bhk=;
 b=fNdfr1zUZpEP3cGM6+Q62mJYpfjjPE0/osc+XqhUl42biV7OFto7+iaSZ/6n3EFBl1bJ
 drSj48GYmT6aCw2ht5L7VNMj8RDHmqAUYAeIH5czv2ac/LC5Scj3dgEMKUcO6n5GAya/
 N1jwy088195Ou7MlzC0RueLPeCqEd6F+C/sIM3q6seCDhI3K4i1EPvIdXdYAe3us+tYq
 3qBu8XWy3Wm8uN2YXGOYp1WWfKQX4A6+gvBSYKlBoGMr4Wkv7g4HmDa6mkS3yJpWbgCU
 EEUllSAJzYFnM2qZKRDUrrXEuQXCKNJTzbACcR4cb2tQhlf/2lex6Dl36fRxSaJqG+/0 sw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3gdt0rg9nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 20:55:28 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id EFA7480024B;
        Tue, 31 May 2022 20:55:26 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 31 May 2022 08:55:23 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 31 May 2022 08:55:23 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 31 May 2022 08:55:23 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrNSh/JA0VLHXmvkDawePIT9QOqzc6/JEt4A/5zFkPjRYFTFWfH3KsmnJcqT9Z3SKxoEIW0Wk57PD/2mioyfKLkBGxpBzWRkKB4g1J+e6GwKTrIAOLplBW16rowLy9M59SfLiEh+Fu7qCIhcskUTFWdQtNwRagjYts51ki6HddAzbNJBaZKkctpQ/f8yV4567Kqpn9P/TSMS68BXBzdnD27Mg4l2geLsKfvmcroHAF1PJ+ENQhWLqe/yOTYYVSSRaofgwe7n89ThPiCegu/IB2DjqHBfdW9DhPb7LG0eYfHpAEwr+ZADBIYSUZD2A9ZrNCwTigN+y4tgqp/Lh0WwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+z1xCKUhzAsnQ7a4zKYo3A8CJl5AEnzVe1QtvUF1bhk=;
 b=LEVZA8EAalLuUqqrCdqmC2sTYC0Czi3pG2CPE5lm6RZg8SGzYEoNxStrG+iJ+YVPLjhNXCqowQTEgB85inIgz64xnl5yaLSJGgIWDr690h44vhLlyYl9tJpOPLiE7yVZxGVwbQBQCRv6+5L09968iMrSdUneKYFX1pwrtYwsF/SapjnnmbUHgLxS9Y+iVk6hP2bFcujLdeV2a+3d9YpyfCyUhHGRW4KosgCWYpZo6SzrfiNvbhVypU9NhjNJI5z0nUwEgC4XuRRpBUShwOde3Y2TBTmCKOYmMsnQ7jqfyujJmxZ/CmDx/9gUyutEiHhReJA1WYy3oOD5l53bx7rkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by IA1PR84MB3057.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 20:55:21 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455%3]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 20:55:20 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: rdma-for-next, rdma_rxe: inconsistent lock state
Thread-Topic: rdma-for-next, rdma_rxe: inconsistent lock state
Thread-Index: AQHYdS+dRzRGj9SWqEOoJ6VA6rKMy605dhPA
Date:   Tue, 31 May 2022 20:55:20 +0000
Message-ID: <MW4PR84MB23075334E3E1CD9483BF4EDABCDC9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <24ed4fac-0519-be62-6817-b4a73050e805@acm.org>
In-Reply-To: <24ed4fac-0519-be62-6817-b4a73050e805@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 627fb54f-58ff-4529-fcea-08da4347e029
x-ms-traffictypediagnostic: IA1PR84MB3057:EE_
x-microsoft-antispam-prvs: <IA1PR84MB305779D4D9DD342C4BEEEF23BCDC9@IA1PR84MB3057.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GXBhQ+dOfJX56po+kS4QYtFRxewnaeqYQhSA+9lj1SFnohxlyNdgPxOARMzcXhUQygNU3njOVIU8LdKvWb/aWA9B3KDQdQ3eJn/U7NPSzHtqNxF5TfDL5cCr5b6TLcsLWS7iG7a6Nk/T1M4PE/YFUaEKWIf9A8eMRwDtrh23g0JE6ZIkzQOo8H34dqMfvibhbr7q1sIin5HC10KMf0qLcYZ1ObZF9Y0kg+YTwAdLmHZZdQraBWRA8a3U1TYSu459tiFqOT/7tmhXS6rphuxrRnQXtZmW9Eg3m7f5o13olO55ykrWWtd8zkZSU/6nM/m6JigAPMjfrgBRi0UnJGq7YH8mlwE216+N4uYMMkqAAtaKSaxlM3FgLQ4Anifrr1QrXKMfYac1291KVQy/7HMnKrZhglFMC2Ag9U7N/XuSYE0dmEiWybad+UTuiP8bMsUm/lXSG1INA7Gz1ARxudMwtgqdSoyw3jjQQLw8JsZvRv6lX8L9EiZdb/a08b5Ec4FLIuWfDRoXs4fBqCX8zhJeI5BhuVLEnR76lpaFnCHBU/JoazwUOLeb+O+KahVOzNT94A3PLJYZBZykhIwTIOoUKlcrCYAc8sOXMzI/bO97tW/NGxr10hUAzR4y2+hacpV1RMdlsC3WOv2k9Nyy2qYBY4ABiMgSlFxu5dY6vjEq5XPBRLGYVVDAQ3wiWnwiPHyqCD7XIphcFs+KewlDrDx4ugE3h+Y8m5ksHY3KDvbSoQY40NbSug8lM+fAMN3dHRE/XepY7YCA8ti2OXKS2P8eVGRCAmLabAvr7IDwydGf4YI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66446008)(186003)(4326008)(66556008)(66946007)(64756008)(83380400001)(76116006)(8676002)(86362001)(2906002)(55016003)(5660300002)(122000001)(82960400001)(38100700002)(52536014)(38070700005)(8936002)(71200400001)(508600001)(7696005)(26005)(9686003)(110136005)(6506007)(33656002)(316002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1EyU0V4NldOZEVob2lVUi90aktHWDdubGxpT0NhdTBMVGR0RlBuc3o0QzZO?=
 =?utf-8?B?bnIrL0VyZnlXUzhMMTgzclQ1TVp1OVZlY29xMGEreXFNNUV2c0NWejlrUWNE?=
 =?utf-8?B?SCtNZTRFRXd4Zko2ZkNrK1ZXd3dYWjdBSnNWcFd0WHhqbU93cC9BNmN0U2g2?=
 =?utf-8?B?TjNWSDJIamJaZy9mT0lzeVR0UVVRVjFodlB0dE9EdzJSS2htUndONG42NUY1?=
 =?utf-8?B?cW9teWx6UTV6dVg2d1ZnVWxqUEdlaWZVbjBycDF6NXRTTU9DNkcyN0xRSmJk?=
 =?utf-8?B?bjEyaVovd1ljaXZ3NTQ2RE1USm9Wc1Z2MnR3dzVSWXFQakQzTXhFWVh0bTd6?=
 =?utf-8?B?R1BuaTQ2b0pHTFQvcVdvTU4yeDZvbFVOZHAwMmZpLzZTTGJGb3VFMXNSWkJR?=
 =?utf-8?B?OVViQngrZEw1OXBNM0Y3Zk9jcXVvVlcreDUzbUdub2FkRTdjYUVqTXpiRGxT?=
 =?utf-8?B?b2FLOEw1bEdwSkJ1dXpWQ0lWMzJ2eUtORDB2ZGpwTkk3MVQwWHVvZDhMVUdu?=
 =?utf-8?B?NmF5S1hudXE5M002bVJQOHo0dENwTFR2cElUd1ZrMys5SkNzaTdZdlVOWDBq?=
 =?utf-8?B?RDE5cmU4QTYybFFFeTRlOWZQOU5STklXczNJdXA3MkpBd2R2WVA4VG9VVG90?=
 =?utf-8?B?RWZVS005OENGOU9ZNjZ4amQxWTZJWFhnWUVNQjJ2TWxPaElhSk1CVzRTZVJF?=
 =?utf-8?B?aU5tM2xnTEdiK0srZ0JmUzZRamVKSDV2K1poWlU0RUhRN0c4UmFXajdKRWdl?=
 =?utf-8?B?QkNucXg4enBJNk80VUlpdE9oTW54Ny92Zm1mdjFnNnJqdlFyS2UwbTBsYVkw?=
 =?utf-8?B?ZGRTS0lTYUNmTUNmUG1GQnIyQmhLWVVDUmZocC8xRWpiNzZZK21xL3E3ZGhx?=
 =?utf-8?B?Vm1oR2RoTzBBU2ZtZVRwazg3ZysrUXNKUnhnSUZkUzYvSVQ1eGsyaEFxTVNu?=
 =?utf-8?B?dDd2d29iSGpJOVZvSDNaN1JpTkdaK2Z5cmF3YUsrTlJ4UHphVWlNZ3krZmR3?=
 =?utf-8?B?bWRTUzJhTmhoOE9nT1M4TC9kNDVFYUFaa1Q0RjhjYitMT2pCMGtNVXVrc2VL?=
 =?utf-8?B?dno1aGRFd1BpUEhKblRhODFsd2E1cFpLcE1YK0NUSllYUzBiakFISHdmYm9Y?=
 =?utf-8?B?RUp4bmpCeHZKTlZxVytHdmNsbTlaa2F3bXV2R3QrN1NQdjZWUngzQmpzbFBm?=
 =?utf-8?B?R2ZlZVZqWkJqL202SU1IYnU1Uy9BbjR5d0VLMmhiREI0czVMenM0T29pYlA2?=
 =?utf-8?B?NHNMK0RtaVdtdEZaMUV1Tkx6aHAzNUFsbDQ1TzBhSUxZQWdPU0t0NnhJNjkr?=
 =?utf-8?B?S3pGelhHRy9CbGhyM2k3VDg3Nmc5STBHRFFRV05WM2NhZU8xRCtnbzZBQU0v?=
 =?utf-8?B?djN5TjcvMXZtZXFnSmwzSGFFL01Db1VBUjVkVnVlQTk1elJtZkZUamVxVTBL?=
 =?utf-8?B?UXZ2UTc2ZUVpUE5wa3R3VHZyT2JwZEdWSTNNVWUzWnRiL1hCN01NSk9tSEVt?=
 =?utf-8?B?NEZUMDVja1IvSXJiRXRNd1dwZG53OVV4b29pcXpRQmRYaWJXZXhobjVrOTdB?=
 =?utf-8?B?YzZ6SlZhMU83ZVN4WlZjV2VHc29tdEdYUkhNMUQ1Zk5tbm42Z3ozc1ZzRmVZ?=
 =?utf-8?B?bmwwbmI3Y3hPYmh6YTR3bzFaZHFBSTRnL1o0YjJQZG5meXBpeWhFb0h5a3VF?=
 =?utf-8?B?bEZqNUdCdHM3bGxBS3VWWTZ0NHgrNFA3ejFHeloweEkwVDBTZWVBdC9aRmE4?=
 =?utf-8?B?TDl4SUpMNkVlY3QwVjRGNkNDTzBOaDRUQWhRVDhCUFJLb2IzTlhteFdYSUxr?=
 =?utf-8?B?SjZWam1ObXhDa1l2S1FESkxNd3dPbjM1S1VmelAwbmh0Y3VrNjhtK2J0UDJW?=
 =?utf-8?B?T1BhTXprSlBzd1dPdElKL2dNWDV2MWJadUNpelVWeTZwaXhjYk1WQU1zajRF?=
 =?utf-8?B?K1hYMFA3MjRZeGltUzR3YjF0RVUxdWNtTHo5dkl4NXc1aGxXa1pFZ3pGTGU0?=
 =?utf-8?B?djBKSVR2UnVyNUV4WGk1OVdiV3NMOXNCSVlOZitGazJiRHprNlN1ODNRdWNU?=
 =?utf-8?B?bHdaYWcvUTluWndGTGJNUUZmeVlYVXEvTWhLVEMxSUdwZVYwUU5VYzBZVTdx?=
 =?utf-8?B?YnRFd0t0bWxkUmlPTzdrVXJ3bFNPSEdaKyt1TUx4VldFbG5HOTdsci94bjFB?=
 =?utf-8?B?Y3dFTlo4bG9qVEtQa1FmVVJqY1BtRVNpNUdFWkErVWovMWRORk1wdmdQT3dl?=
 =?utf-8?B?U1piWWZyYXNtVVpzZis5TGdNU2ljSW96TVRaNzhzeGNtUUYxTmpiT0xlUU1y?=
 =?utf-8?B?amdxeTk4NVVUTFJjd2sxRDlLbm1wa2xGcjBJN2tTbzdQd1E1bTdjZz09?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 627fb54f-58ff-4529-fcea-08da4347e029
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 20:55:20.8777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3ggH1by12CBh9OWTiGrq1o9aFm2IWGh1FDqQ3tjFWtgRg87O9Roe27K9HmcToewaI7dEbyBT/MQyKQO9B7/2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR84MB3057
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: pOqHxZH8NcOCVDxGHRKx82KVWF4R2_lg
X-Proofpoint-GUID: pOqHxZH8NcOCVDxGHRKx82KVWF4R2_lg
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310091
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2
YW5hc3NjaGVAYWNtLm9yZz4gDQpTZW50OiBUdWVzZGF5LCBNYXkgMzEsIDIwMjIgMzo0NyBQTQ0K
VG86IEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+DQpDYzogbGludXgtcmRtYUB2
Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IHJkbWEtZm9yLW5leHQsIHJkbWFfcnhlOiBpbmNvbnNp
c3RlbnQgbG9jayBzdGF0ZQ0KDQpIaSBCb2IsDQoNCldpdGggdGhlIHJkbWEtZm9yLW5leHQgYnJh
bmNoIChjb21taXQgOWM0NzcxNzhhMGExICgiUkRNQS9ydHJzLWNsdDogRml4IG9uZSBrZXJuZWwt
ZG9jIGNvbW1lbnQiKSkgSSBzZWUgdGhlIGZvbGxvd2luZzoNCg0KPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCldBUk5JTkc6IGluY29uc2lzdGVudCBsb2NrIHN0YXRlDQo1LjE4LjAt
ZGJnICM0IE5vdCB0YWludGVkDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KaW5j
b25zaXN0ZW50IHtTT0ZUSVJRLU9OLVd9IC0+IHtJTi1TT0ZUSVJRLVd9IHVzYWdlLg0Ka3NvZnRp
cnFkLzIvMjUgW0hDMFswXTpTQzFbMV06SEUwOlNFMF0gdGFrZXM6DQpmZmZmODg4MTE2ZjBkMzUw
ICgmeGEtPnhhX2xvY2sjMTIpeysuPy59LXsyOjJ9LCBhdDogcnhlX3Bvb2xfZ2V0X2luZGV4KzB4
NzMvMHgxNzAgW3JkbWFfcnhlXSB7U09GVElSUS1PTi1XfSBzdGF0ZSB3YXMgcmVnaXN0ZXJlZCBh
dDoNCiAgIF9fbG9ja19hY3F1aXJlKzB4NDViLzB4Y2UwDQogICBsb2NrX2FjcXVpcmUrMHgxOGEv
MHg0NTANCiAgIF9yYXdfc3Bpbl9sb2NrKzB4MzQvMHg1MA0KICAgX19yeGVfYWRkX3RvX3Bvb2wr
MHhjYy8weDE0MCBbcmRtYV9yeGVdDQogICByeGVfYWxsb2NfcGQrMHgyZC8weDQwIFtyZG1hX3J4
ZV0NCiAgIF9faWJfYWxsb2NfcGQrMHhhMy8weDI3MCBbaWJfY29yZV0NCiAgIGliX21hZF9wb3J0
X29wZW4rMHg0NGEvMHg3OTAgW2liX2NvcmVdDQogICBpYl9tYWRfaW5pdF9kZXZpY2UrMHg4ZS8w
eDExMCBbaWJfY29yZV0NCiAgIGFkZF9jbGllbnRfY29udGV4dCsweDI2YS8weDMzMCBbaWJfY29y
ZV0NCiAgIGVuYWJsZV9kZXZpY2VfYW5kX2dldCsweDE2OS8weDJiMCBbaWJfY29yZV0NCiAgIGli
X3JlZ2lzdGVyX2RldmljZSsweDI2Zi8weDMzMCBbaWJfY29yZV0NCiAgIHJ4ZV9yZWdpc3Rlcl9k
ZXZpY2UrMHgxYjQvMHgxZDAgW3JkbWFfcnhlXQ0KICAgcnhlX2FkZCsweDhjLzB4YzAgW3JkbWFf
cnhlXQ0KICAgcnhlX25ldF9hZGQrMHg1Yi8weDkwIFtyZG1hX3J4ZV0NCiAgIHJ4ZV9uZXdsaW5r
KzB4NzEvMHg4MCBbcmRtYV9yeGVdDQogICBubGRldl9uZXdsaW5rKzB4MjFlLzB4MzcwIFtpYl9j
b3JlXQ0KICAgcmRtYV9ubF9yY3ZfbXNnKzB4MjAwLzB4NDEwIFtpYl9jb3JlXQ0KICAgcmRtYV9u
bF9yY3YrMHgxNDAvMHgyMjAgW2liX2NvcmVdDQogICBuZXRsaW5rX3VuaWNhc3QrMHgzMDcvMHg0
NjANCiAgIG5ldGxpbmtfc2VuZG1zZysweDQyMi8weDc1MA0KICAgX19zeXNfc2VuZHRvKzB4MWMy
LzB4MjUwDQogICBfX3g2NF9zeXNfc2VuZHRvKzB4N2YvMHg5MA0KICAgZG9fc3lzY2FsbF82NCsw
eDM1LzB4ODANCiAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YWUNCmly
cSBldmVudCBzdGFtcDogNzE1NDMNCmhhcmRpcnFzIGxhc3QgIGVuYWJsZWQgYXQgKDcxNTQyKTog
WzxmZmZmZmZmZjgxMGNkYzI4Pl0gX19sb2NhbF9iaF9lbmFibGVfaXArMHg4OC8weGYwIGhhcmRp
cnFzIGxhc3QgZGlzYWJsZWQgYXQgKDcxNTQzKTogWzxmZmZmZmZmZjgxZTlkNjdkPl0gX3Jhd19z
cGluX2xvY2tfaXJxc2F2ZSsweDVkLzB4NjAgc29mdGlycXMgbGFzdCAgZW5hYmxlZCBhdCAoNzE1
MzIpOiBbPGZmZmZmZmZmODIyMDA0Njc+XSBfX2RvX3NvZnRpcnErMHg0NjcvMHg2ZTEgc29mdGly
cXMgbGFzdCBkaXNhYmxlZCBhdCAoNzE1MzcpOiBbPGZmZmZmZmZmODEwY2RhNDc+XSBydW5fa3Nv
ZnRpcnFkKzB4MzcvMHg2MA0KDQpvdGhlciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1cyBkZWJ1ZyB0
aGlzOg0KICBQb3NzaWJsZSB1bnNhZmUgbG9ja2luZyBzY2VuYXJpbzoNCiAgICAgICAgQ1BVMA0K
ICAgICAgICAtLS0tDQogICBsb2NrKCZ4YS0+eGFfbG9jayMxMik7DQogICA8SW50ZXJydXB0Pg0K
ICAgICBsb2NrKCZ4YS0+eGFfbG9jayMxMik7DQoNCiAgKioqIERFQURMT0NLICoqKg0Kbm8gbG9j
a3MgaGVsZCBieSBrc29mdGlycWQvMi8yNS4NCg0Kc3RhY2sgYmFja3RyYWNlOg0KQ1BVOiAyIFBJ
RDogMjUgQ29tbToga3NvZnRpcnFkLzIgTm90IHRhaW50ZWQgNS4xOC4wLWRiZyAjNCBIYXJkd2Fy
ZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyByZWwt
MS4xNS4wLTAtZzJkZDRiOWItcmVidWlsdC5vcGVuc3VzZS5vcmcgMDQvMDEvMjAxNCBDYWxsIFRy
YWNlOg0KICA8VEFTSz4NCiAgc2hvd19zdGFjaysweDUyLzB4NTgNCiAgZHVtcF9zdGFja19sdmwr
MHg1Yi8weDgyDQogIGR1bXBfc3RhY2srMHgxMC8weDEyDQogIHByaW50X3VzYWdlX2J1Zy5wYXJ0
LjArMHgyOWMvMHgyYWINCiAgbWFya19sb2NrX2lycS5jb2xkKzB4NTQvMHhiZg0KICBtYXJrX2xv
Y2sucGFydC4wKzB4M2Y1LzB4YTcwDQogIG1hcmtfdXNhZ2UrMHg3NC8weDFhMA0KICBfX2xvY2tf
YWNxdWlyZSsweDQ1Yi8weGNlMA0KICBsb2NrX2FjcXVpcmUrMHgxOGEvMHg0NTANCiAgX3Jhd19z
cGluX2xvY2tfaXJxc2F2ZSsweDQzLzB4NjANCiAgcnhlX3Bvb2xfZ2V0X2luZGV4KzB4NzMvMHgx
NzAgW3JkbWFfcnhlXQ0KICByeGVfZ2V0X2F2KzB4Y2MvMHgxNDAgW3JkbWFfcnhlXQ0KICByeGVf
cmVxdWVzdGVyKzB4MzRjLzB4ZTYwIFtyZG1hX3J4ZV0NCiAgcnhlX2RvX3Rhc2srMHhjYy8weDE0
MCBbcmRtYV9yeGVdDQogIHRhc2tsZXRfYWN0aW9uX2NvbW1vbi5jb25zdHByb3AuMCsweDE2OC8w
eDFiMA0KICB0YXNrbGV0X2FjdGlvbisweDQyLzB4NjANCiAgX19kb19zb2Z0aXJxKzB4MWQ4LzB4
NmUxDQogIHJ1bl9rc29mdGlycWQrMHgzNy8weDYwDQogIHNtcGJvb3RfdGhyZWFkX2ZuKzB4MzAy
LzB4NDEwDQogIGt0aHJlYWQrMHgxODMvMHgxYzANCiAgcmV0X2Zyb21fZm9yaysweDFmLzB4MzAN
CiAgPC9UQVNLPg0KDQpJcyB0aGlzIHBlcmhhcHMgdGhlIHNhbWUgaXNzdWUgYXMgd2hhdCBJIHJl
cG9ydGVkIG9uIE1heSA2IChodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvY2Y4Yjk5ODAtMzk2
NS1hNGY2LTA3ZTAtZDRiMjU3NTViMGRiQGFjbS5vcmcvKT8NCg0KVGhhbmtzLA0KDQpCYXJ0Lg0K
DQooZnJvbSB3aW5kb3dzKQ0KDQpZZXMuIFRoZXJlIGlzIGEgbG9jayBsZXZlbCBidWcgaW4gcnhl
X3Bvb2wuYyB0aGF0IHJlcXVpcmVzIGEgcGF0Y2ggdG8gZml4LiBJIGhhdmUgb25lIHRoYXQgaXMg
YSB0ZW1wb3JhcnkgZml4Lg0KWmh1IGhhZCBvbmUgdGhhdCBoZSBwb3N0ZWQgIHdoaWxlIGFnbyBi
dXQgd2FzIG5ldmVyIGFjY2VwdGVkLiBJIGRvbid0IHdhbnQgdG8gc3RlcCBvbiBoaXMgdG9lcy4N
ClRoaXMgaXMgcmVsYXRlZCB0byB0aGUgIkFIIGJ1ZyIgaS5lLiByZG1hY20gaG9sZGluZyBsb2Nr
cyB3aGlsZSBjYWxsaW5nIGludG8gdGhlIHZlcmJzIEFQSXMgd2hpY2ggaXMganVzdCBwbGFpbiBl
dmlsLg0KDQpJJ2xsIHNlbmQgeW91IG15IHBhdGNoLg0KDQpCb2INCg==
