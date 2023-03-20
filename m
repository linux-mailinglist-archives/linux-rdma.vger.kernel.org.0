Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9926C0FE3
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 11:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjCTK5t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 06:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjCTK5Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 06:57:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86D28EA7
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 03:54:02 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K8bh7P016961
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 10:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=7N9F2z/4ZRENY747XzQXARXLox7zPtZ/L9Iy1Bohf4Q=;
 b=BKdvMAdBfRXidM+Hy5bjeVhYGDh0/CSa40pioJSoK5dBdq8aqrDgyQ2qNzkvsbt7pTya
 XpjLUNzA+jxKUYGLr4IXItXnfN/lKdKkVuGfU+9o857CZALoVDiEc8ixVCtHVUHCcpxz
 4keNzgzBS6u3M19vwy/fWm7YlZM/NoDq1SI6ihgP1lioAvvb6sn0VDzcuvudcKw5rZ9v
 IIT8krzClGyTmJ1guETXJHaxlLHK07p3/mgUqcoLYqqofM9xXe0MrQKvKg0o9WoSFhDB
 qJ7Mg4jFdIOI2oW8ZraP1FwKXUvHjwo+Ly7cHeFV3cvalOSXIGX8CiRwXl50MoqXL777 dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pdq3tnhvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 10:53:12 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32KAeNFZ004495
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 10:53:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pdq3tnhv8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 10:53:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O24MFf2E//EoXaF1SwqOS5JQgp6f9xqXfdnfcb44zcT/1POT2oyZQAnxQEiCwkPNTprccH4I7bnpV861kXPwWProN3dKQGbt6kU/nuRnoNVnGaFOmftRDMESW6yBIMhhPcKR27e4keDd0FxdxV5zSsu5ztq7pbqRLSMgA/mtTQVSQiX73BHTWWaXix/pOh3ePJPOW3lWSUAn46n22V39LabO5cDRQnvwXWUQ9BvTnz4WL+ZAKChqz+0rx+qSxcJfSX9eoCS99ZIQTeJw5KoHQ7rJumw0RAjKgyaZ/8B3i735dzJ6Ew8qdaAmz9zcbX/BQZ7Og+ivceMACT3/Pb3Oyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7N9F2z/4ZRENY747XzQXARXLox7zPtZ/L9Iy1Bohf4Q=;
 b=jkAPoSuvJYa/uYRaI9VY/tY25Peyz0Fv6M2oGGtHxL1qaaarOcQ8YWQOS7PFyWrsGiCxA1766Ey0UZ80ujCeaeUFUiD2MhddF4oRV7d9HBjAgfQpNEcNOys2JUL7K1NWyxO7OgXGeMDKRj2mKm/7zWpKkT7i1Ag3LixjJ10ldRI7XqRdMHE15zPN21nmWCGWn7itk3vBRqJadeqW6qFjLgd627qPAY6+GyIeCz8Bn2j8smlRNthsFJVXPVG2PIPPH6IM58ASLWnaJBmk5SKTzmp4SjY04t2rOluNHGnaA11vGm7XORE7hl7q0VEbeT7qqHXOeHLsrUhJCl3+ZkEqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by SA0PR15MB3997.namprd15.prod.outlook.com (2603:10b6:806:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 10:53:09 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99%5]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 10:53:05 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     David Howells <dhowells@redhat.com>
CC:     David Howells <dhowells@redhat.com>, Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] [RFC PATCH 08/28] siw: Inline do_tcp_sendpages()
Thread-Index: AQHZWBu8o69PCqlItkmo3qg1mbxttK8Ddo0A
Date:   Mon, 20 Mar 2023 10:53:05 +0000
Message-ID: <SA0PR15MB3919A01D3E69110345ED0EC799809@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20230316152618.711970-1-dhowells@redhat.com>
 <20230316152618.711970-9-dhowells@redhat.com>
In-Reply-To: <20230316152618.711970-9-dhowells@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|SA0PR15MB3997:EE_
x-ms-office365-filtering-correlation-id: 8c0ab260-1b71-4640-31ab-08db293148d2
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbil2XY+j4HnE+o8IfM6YB6ClpAwKS5ghhoRwTi7TLBj4Eu+L1YrQFj6BvydEeIr+HFDoL41Yo2+rpkPHixergFOdl8cNV2Z8LZPhu4nD2E4X5fO6mNBX8zaREBArdbVmlFNIdtMS0tr1LNAfqUfOYFlTmbItKkByzZUjSRv8ZB2m6oD4JDgZyp0U6YhEnHHiAQaClVMrlKIN0s4Njqbo9+arav29wdXysrjX9We6W/witvjUViY3s8dB0DVgAs1KCRnWxJiF/xLLburDEK+RxH9lo81JIzptbp6BJ+wbaS/+l6eNlzpMVtsN8KV7oDTgPsI4J6kuYny/vrrudddsD0NDkF7AjeT/cD5EuOJid3geKvHHTCEPxJzx556q9zF5QYzW2SksjW3Tq+jVjzMJ1mjaufhxPH0q50VcPMRZJRq+4oF3ugv6GgNjOg+HRSHu3UshSpzmiNtoSwiubuIJB8xHNXgiNwR8ke6cKzfP7a6smnuQ5Fu0zO47CcOPWtMcmDO4NossVePJooyBsbTTe7RNsQIQV+z1IDVE68X3z+rzQiVcIBLzXbkjgd1ZFEa+IcnXmmkWuloVNFeYUyr5w5f/b3pFUGz+do8ouokLdjx4QoulUPbRtmIH68jCO6hbntI3DBEL3E4j74QTQkBxeWmxid1k9GQQzBhsdL9ryeBbwsNW9kbXsUu1omvcVu9fWdNxj4veUNXaEpXT0HeoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199018)(7696005)(86362001)(33656002)(55016003)(71200400001)(4326008)(66476007)(66446008)(64756008)(66946007)(8676002)(83380400001)(6916009)(66556008)(316002)(478600001)(53546011)(5660300002)(9686003)(6506007)(54906003)(186003)(76116006)(38100700002)(38070700005)(8936002)(52536014)(2906002)(122000001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXZBeHNtczU0dWQwUEVpbDhBb0NtSWZYRVhWbFpZVTAxQm4zNGFaN1ZSUGpx?=
 =?utf-8?B?K2ZUNzJreUlVeU5tNGFXcW04b0hrMGRmYVVCQTZlU1FHN0c0UkFPMDVTMk02?=
 =?utf-8?B?YWFzcUtjKzVORTBmd0VTQWxtaWM2VXdIMFAxTDAzZGlEekQwREVKUFB6bjNy?=
 =?utf-8?B?WXAxbk9YT21GdlBObzUyaVNUbllXSmNmbzNOZkl0dDlkRE9nTU5BM2JZT0Vp?=
 =?utf-8?B?MDM5dFY1SjZtQUlrSVU3Sm9ONk1QcFB1c2FtUk9LS0pwMFViRkJoNmJFWXk4?=
 =?utf-8?B?eFkvUzdBUklObEF2NWVUdE1SV3o4ZVo5SWdhcFI0SVFkNGZQVVU0YUovdWhE?=
 =?utf-8?B?Q1pCcG5wZU1qQmN1TkZxYkVJOW02azhmcm5OU0NiOS9RNFdwYXJuMGYvTk9I?=
 =?utf-8?B?eHlaVlRhRXcrOFNmc24xS2tqZlRiT0kwOEJFeWdXakFHYlVVbUhWd2ZHb3dG?=
 =?utf-8?B?eFlJZnRmY2RYWlU1bm1ka0NCTCtCeDcwdTJ1SXBHWGRrN1Q5YkFTYStva3Jk?=
 =?utf-8?B?V2p0MFJHVXRHNzFWY0hsS20rblFYRzJmRGNoOXdTZVhwbkVwWGROTWhnN3pa?=
 =?utf-8?B?S2QvSHlIVHNYMFN4S0pUYjZTaXMzbDUzN0Naamt2bWhrYU1kOUFkKzNqc1pB?=
 =?utf-8?B?UWNzMWlDaVVVYXdUZkZ4Q1MxUTNRTGtSL1NNTGJremxsT1gzTWR3Rk10Y1Zl?=
 =?utf-8?B?MGtUaGV1NW1CUkgvQ0FlREhTMEVUdklTd3ptdDBLY2tiSEJSbHdNMXg3Z3Bz?=
 =?utf-8?B?dVNWZVp3cW83bWtIcHhUSWRSN3hJYlFXRkwvejlub3JRQjUrUHlram4vLzJZ?=
 =?utf-8?B?cEtHa3BSU3BQT2s4ZlBULzA3N3dhZ0lhaVE1bWx3YXNvcldCUUFSYldpWjVi?=
 =?utf-8?B?bDNXMlZWVkxXbzVCUG9PMG1TNWprRVVMUlIrVitUSEdyWEJmZkpwZE1vN3dq?=
 =?utf-8?B?UHdVUkRZc3ZzbCsvVXBMZytuaFFWeTE2aCtKdXJYTWhvZlBPb2QwYUhJWDFt?=
 =?utf-8?B?aGIvQlJ0bHBhT1NsbElxRkRpdE11bVhXUE8vbHQwUFRpWnppNVcvQ3lDeFhq?=
 =?utf-8?B?WFdIWWYwZ2w1YzV6QkYvZWtscUZsY3V5T1U1Mzg4eDJDK0tJZk1SMEFNc3lx?=
 =?utf-8?B?Q1MySzdQbzZhR3YzNTZ1TjYzY1VZWTNYRzl5SlBlcnMvdUJaMjliRkN2M0Nv?=
 =?utf-8?B?aGZ0MkNWZUl0ZHZ4NW0rNFBCQUxlT1hUS3NDVVFsd291SThVQWNCL0NwTSti?=
 =?utf-8?B?L0JsMzZMOE5KcUlSWWhGbWhpdHlpQ3NCNk5EQy9rRHRsOGFrSkFYcGJnNjFi?=
 =?utf-8?B?ZHh3VmhIVWd0L1h6cE50THhRVGtMMzZqRVRuOVZpK0R6cklBNTd2WUVUTFNB?=
 =?utf-8?B?Y3J0eUpvOTlQSXBUcFFhNFJzN2lrTWhzb3NjekQrbmtLTTJ4SFBzNXF6eWZ3?=
 =?utf-8?B?cStkSFY0WExjdmNhN1QycTlwaWw0NnNXbk9RMWFBT0ozQTFGeTJyWUEydk9s?=
 =?utf-8?B?blBpQis2UlpQc1UyUndIM211cmhJTmxjTEp5cHIrOHR3RkthSy9lTXVUVEUx?=
 =?utf-8?B?QmRNSVBjdmk5MGxFMjJLZVZXOHlDeWR5SXR6WGQ0dWhjaWhqNGFGSEZyYjRm?=
 =?utf-8?B?SVkwSU5sbS9rbnpiVlJOL1NCOXRYU1VJS1I4SnVyK3dlTThYQWVUQ0Ziek9F?=
 =?utf-8?B?Ym9kR0pyZy9VbDB0dzllcUFZdm54YzFXc0dmMGdDWHZUYk9Saml5Zk9QTW1N?=
 =?utf-8?B?YjRSMlZmdnltRVRKY3ZSNmlFN0N6WDdOYnhnN2VLMmdlNEpNYXpHdkdGV0RC?=
 =?utf-8?B?SFltNzZIMUJEbkEwcnlNSTNZc1pWMDBxdS8xSXA3NXJsVXVMbnl3UXV4YTBJ?=
 =?utf-8?B?bDRST09jMHh4emZXY01sSjM4aHdTN25qelBrVmhocGNNUXBIU0x1QU1vZ09Y?=
 =?utf-8?B?R0d2NUF3VVhKMVZQUHh6b3BKb3dEMUxUSTZJTXh2TGNka3FLN0ExYzRPdHEw?=
 =?utf-8?B?M2pDMkkxTkhFK0tJUzFYbTJFeW0wK3BTcTl1TVRPc1doNWJiUnp3NklCdlpz?=
 =?utf-8?B?a0xmaUI1Zlc2UDlXbGhTek1xTHVHTVZPSWVYK2dlL3EvN2daV0srVklyMkxr?=
 =?utf-8?B?ZHRTZTBzVE4wamhxRnU5RGxyTmlpbnhpUDFnQ3dDRmtrRzdBYXFWbnc0MXE5?=
 =?utf-8?Q?+9ZYosCru3MI+GTFVKHdVa0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0ab260-1b71-4640-31ab-08db293148d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 10:53:05.4460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etyJyaItrGX4JozRRBb/JN77h3W3KPb1cZVDalEJeeVhVvZmy/XHAWEUxZog176mNawXnBC1eAyZ9Hu0c8VbGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3997
X-Proofpoint-ORIG-GUID: X5yMg9r_qSbcsbhEoguvpIcXjrsco63F
X-Proofpoint-GUID: OMonixC5avZ34O6xqUbNMiAfdyOHn3y4
Subject: RE:  [RFC PATCH 08/28] siw: Inline do_tcp_sendpages()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_06,2023-03-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxlogscore=740 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303200089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgSG93ZWxscyA8
ZGhvd2VsbHNAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIDE2IE1hcmNoIDIwMjMgMTY6
MjYNCj4gVG86IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPjsgRGF2aWQgUy4g
TWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBn
b29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kNCj4gPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFi
ZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4NCj4gQ2M6IERhdmlkIEhvd2VsbHMgPGRob3dlbGxzQHJl
ZGhhdC5jb20+OyBBbCBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az47DQo+IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz47IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az47IEplZmYNCj4gTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+OyBDaHJpc3RpYW4gQnJhdW5l
ciA8YnJhdW5lckBrZXJuZWwub3JnPjsgTGludXMNCj4gVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4
LWZvdW5kYXRpb24ub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGZzZGV2
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1t
bUBrdmFjay5vcmc7DQo+IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgVG9t
IFRhbHBleSA8dG9tQHRhbHBleS5jb20+OyBsaW51eC0NCj4gcmRtYUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUkZDIFBBVENIIDA4LzI4XSBzaXc6IElubGluZSBkb190
Y3Bfc2VuZHBhZ2VzKCkNCj4gDQo+IGRvX3RjcF9zZW5kcGFnZXMoKSBpcyBub3cganVzdCBhIHNt
YWxsIHdyYXBwZXIgYXJvdW5kIHRjcF9zZW5kbXNnX2xvY2tlZCgpLA0KPiBzbyBpbmxpbmUgaXQs
IGFsbG93aW5nIGRvX3RjcF9zZW5kcGFnZXMoKSB0byBiZSByZW1vdmVkLiAgVGhpcyBpcyBwYXJ0
IG9mDQo+IHJlcGxhY2luZyAtPnNlbmRwYWdlKCkgd2l0aCBhIGNhbGwgdG8gc2VuZG1zZygpIHdp
dGggTVNHX1NQTElDRV9QQUdFUyBzZXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBIb3dl
bGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPg0KPiBjYzogQmVybmFyZCBNZXR6bGVyIDxibXRAenVy
aWNoLmlibS5jb20+DQo+IGNjOiBUb20gVGFscGV5IDx0b21AdGFscGV5LmNvbT4NCj4gY2M6ICJE
YXZpZCBTLiBNaWxsZXIiIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KPiBjYzogRXJpYyBEdW1hemV0
IDxlZHVtYXpldEBnb29nbGUuY29tPg0KPiBjYzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVs
Lm9yZz4NCj4gY2M6IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4NCj4gY2M6IEplbnMg
QXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj4gY2M6IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZy
YWRlYWQub3JnPg0KPiBjYzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gY2M6IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Np
d19xcF90eC5jIHwgMTcgKysrKysrKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
c2l3L3Npd19xcF90eC5jDQo+IGluZGV4IDA1MDUyYjQ5MTA3Zi4uOGZjMTc5MzIxZTJiIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+ICsrKyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4gQEAgLTMxMyw3ICszMTMs
NyBAQCBzdGF0aWMgaW50IHNpd190eF9jdHJsKHN0cnVjdCBzaXdfaXdhcnBfdHggKmNfdHgsDQo+
IHN0cnVjdCBzb2NrZXQgKnMsDQo+ICB9DQo+IA0KDQoNCkhpIERhdmlkLA0KDQptYW55IHRoYW5r
cyBmb3IgbG9va2luZyBpbnRvIHRoYXQhDQoNCkkgcmVwbHkgdG8gYSBsaW1pdGVkIGF1ZGllbmNl
LCBleHBlY3RpbmcgbGltaXRlZCBpbnRlcmVzdCwNCmJhc2ljYWxseSB0byB0aGUgcmRtYSBsaXN0
IHBsdXMgVG9tLg0KDQoNCj4gIC8qDQo+IC0gKiAwY29weSBUQ1AgdHJhbnNtaXQgaW50ZXJmYWNl
OiBVc2UgZG9fdGNwX3NlbmRwYWdlcy4NCj4gKyAqIDBjb3B5IFRDUCB0cmFuc21pdCBpbnRlcmZh
Y2U6IFVzZSBNU0dfU1BMSUNFX1BBR0VTLg0KPiAgICoNCj4gICAqIFVzaW5nIHNlbmRwYWdlIHRv
IHB1c2ggcGFnZSBieSBwYWdlIGFwcGVhcnMgdG8gYmUgbGVzcyBlZmZpY2llbnQNCj4gICAqIHRo
YW4gdXNpbmcgc2VuZG1zZywgZXZlbiBpZiBkYXRhIGFyZSBjb3BpZWQuDQoNClRoYXQgaXMgYW4g
aW50ZXJlc3Rpbmcgb2JzZXJ2YXRpb24uIElzIGVmZmljaWVuY3kgdG8gYmUgcmVhZCBhcw0KQ1BV
IGxvYWQsIG9yIHRocm91Z2hwdXQgb24gdGhlIHdpcmUsIG9yIGJvdGg/DQoNCkJhY2sgaW4gdGhl
IGRheXMsIEkgaW50cm9kdWNlZCB0aGF0IHpjb3B5IHBhdGggZm9yIGVmZmljaWVuY3kNCnJlYXNv
bnMgLSBnZXR0aW5nIGJvdGggYmV0dGVyIHRocm91Z2hwdXQgYW5kIGxlc3MgQ1BVIGxvYWQuDQpJ
IGxvb2tlZCBhdCBib3RoIFdSSVRFIGFuZCBSRUFEIHBlcmZvcm1hbmNlLiBVc2luZw0KZG9fdGNw
X3NlbmRwYWdlcygpIGlzIGN1cnJlbnRseSBsaW1pdGVkIHRvIHByb2Nlc3Npbmcgd29yaw0Kd2hp
Y2ggaXMgbm90IHJlZ2lzdGVyZWQgd2l0aCBsb2NhbCBjb21wbGV0aW9uIGdlbmVyYXRpb24uDQpS
ZXBseWluZyB0byBhIHJlbW90ZSBSRUFEIHJlcXVlc3QgaXMgYSB0eXBpY2FsIGNhc2UuIERpZA0K
eW91IGNoZWNrIHdpdGggUkVBRD8NCg0KPiBAQCAtMzI0LDIwICszMjQsMjcgQEAgc3RhdGljIGlu
dCBzaXdfdHhfY3RybChzdHJ1Y3Qgc2l3X2l3YXJwX3R4ICpjX3R4LA0KPiBzdHJ1Y3Qgc29ja2V0
ICpzLA0KPiAgc3RhdGljIGludCBzaXdfdGNwX3NlbmRwYWdlcyhzdHJ1Y3Qgc29ja2V0ICpzLCBz
dHJ1Y3QgcGFnZSAqKnBhZ2UsIGludA0KPiBvZmZzZXQsDQo+ICAJCQkgICAgIHNpemVfdCBzaXpl
KQ0KPiAgew0KPiArCXN0cnVjdCBiaW9fdmVjIGJ2ZWM7DQo+ICsJc3RydWN0IG1zZ2hkciBtc2cg
PSB7DQo+ICsJCS5tc2dfZmxhZ3MgPSAoTVNHX1NQTElDRV9QQUdFUyB8IE1TR19NT1JFIHwgTVNH
X0RPTlRXQUlUIHwNCj4gKwkJCSAgICAgIE1TR19TRU5EUEFHRV9OT1RMQVNUKSwNCj4gKwl9Ow0K
PiAgCXN0cnVjdCBzb2NrICpzayA9IHMtPnNrOw0KPiAtCWludCBpID0gMCwgcnYgPSAwLCBzZW50
ID0gMCwNCj4gLQkgICAgZmxhZ3MgPSBNU0dfTU9SRSB8IE1TR19ET05UV0FJVCB8IE1TR19TRU5E
UEFHRV9OT1RMQVNUOw0KPiArCWludCBpID0gMCwgcnYgPSAwLCBzZW50ID0gMDsNCj4gDQo+ICAJ
d2hpbGUgKHNpemUpIHsNCj4gIAkJc2l6ZV90IGJ5dGVzID0gbWluX3Qoc2l6ZV90LCBQQUdFX1NJ
WkUgLSBvZmZzZXQsIHNpemUpOw0KPiANCj4gIAkJaWYgKHNpemUgKyBvZmZzZXQgPD0gUEFHRV9T
SVpFKQ0KPiAtCQkJZmxhZ3MgPSBNU0dfTU9SRSB8IE1TR19ET05UV0FJVDsNCj4gKwkJCW1zZy5t
c2dfZmxhZ3MgPSBNU0dfU1BMSUNFX1BBR0VTIHwgTVNHX01PUkUgfA0KPiBNU0dfRE9OVFdBSVQ7
DQo+IA0KPiAgCQl0Y3BfcmF0ZV9jaGVja19hcHBfbGltaXRlZChzayk7DQo+ICsJCWJ2ZWNfc2V0
X3BhZ2UoJmJ2ZWMsIHBhZ2VbaV0sIGJ5dGVzLCBvZmZzZXQpOw0KPiArCQlpb3ZfaXRlcl9idmVj
KCZtc2cubXNnX2l0ZXIsIElURVJfU09VUkNFLCAmYnZlYywgMSwgc2l6ZSk7DQo+ICsNCj4gIHRy
eV9wYWdlX2FnYWluOg0KPiAgCQlsb2NrX3NvY2soc2spOw0KPiAtCQlydiA9IGRvX3RjcF9zZW5k
cGFnZXMoc2ssIHBhZ2VbaV0sIG9mZnNldCwgYnl0ZXMsIGZsYWdzKTsNCj4gKwkJcnYgPSB0Y3Bf
c2VuZG1zZ19sb2NrZWQoc2ssICZtc2csIHNpemUpOw0KDQpXb3VsZCB0aGF0IHRjcF9zZW5kbXNn
X2xvY2tlZCgpIHdpdGggYSBtc2cgZmxhZ2dlZA0KTVNHX1NQTElDRV9QQUdFUyBzdGlsbCBoYXZl
IHplcm8gY29weSBzZW1hbnRpY3M/DQoNCg0KPiAgCQlyZWxlYXNlX3NvY2soc2spOw0KPiANCj4g
IAkJaWYgKHJ2ID4gMCkgew0KDQo=
