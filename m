Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2B47319F2
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jun 2023 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245607AbjFON3P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jun 2023 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241229AbjFON2p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Jun 2023 09:28:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F492721
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jun 2023 06:28:41 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FD8AS9019557;
        Thu, 15 Jun 2023 13:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1o4W7o9/G4l0Xcwh4GOWeJmiTkUiVk7CQixUi8B3JVA=;
 b=M5aFkQLiMRXOw5yFqSkuv/IvsjehxXg8FOYcsyqXbZ7rPGj4f7Lwp6gP6dshuOQWRDCx
 n8mZQKXs+v6RfXfVClWInxDzSVUD3zMXQpdPj0wZqVPJEZEiPjCE10XSy7w6q6qV6U+x
 O2cVUbOo9awG9WlZ45b2Zh4+gRZo0/akRz6/fz+Jzd61Xg6C8Rg8ypNdlFGaFPc6tLUf
 q0mqmR3CKRGzGUZa4j/33dDN1g2tboEDUNCe6SiLlhtyAcyCWWeS/eVSYQhYFNY9hWy/
 0eMD8MCc5dQ2c7qNqcQWX4TPsq2T/k+8KVbyYYgajHzZtDb/ARakf3zqzNVd6evtKDob sA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdsvty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 13:28:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FDMoEl033622;
        Thu, 15 Jun 2023 13:28:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6x622-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 13:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HO8NiJbOu/fkJWorO89aTdWgLfnIBmJhv20sx6B0pl+Kg0TfCHM3ry16wD8dc0yYH1zWQ1H3cKN0KA5DKku6aw4kP/FVDA4UfExhnJGarbNAPOIiu4a7TS8QZs66aFganDasYUdJss6+IF+McQ/a4UXTNw5CQrPnumu3FM82yGOdHP1zoUiQJwT5LcPXjbv55pcvJuj7pmTt0BS/ZZRtPEwxon8xCr2lao11EXWKfZwnOhKQfNczNNd6X6LmKUGlhX/TLzxMYD34OZee/uI6/aWyv79UKDFS9r3pB1u0rspGWy6tqmuCanOISQ3y9+3kvQPBKmsPCNSGt3GzbWlqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o4W7o9/G4l0Xcwh4GOWeJmiTkUiVk7CQixUi8B3JVA=;
 b=f0aI/J+BX0CpYMRkZQu5V4XcSv3AnKr0DB7NMpn5nByCx9oRa6H/mGxVEvaBn6ZpUh7W6VAQFtFUbeuxHP4Jq83lTGb5MJtmjYP1RDRAmq1CxBpUelT2YIF6FWakYzvkVtUA/cXBh9Ytk5iR3yRvrlqSr1vGzFslovkJxQx5OcRTQfC28qjw/3ga9OEgAWXxa0ChEH5pWB/6nx2kNi8ShX27R+PwhDLMI3ozhcp6Z9k9IwZOUDnE7VLIwqEQvZYA1PzcEgGwjZDRmk8xG+cnQfPVhl8MIzE55fCXNUGwnJIPW8c7vWJBe7YCygJ59n8bKlmc64HzijUWT0TwoWYf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o4W7o9/G4l0Xcwh4GOWeJmiTkUiVk7CQixUi8B3JVA=;
 b=ckLi79tlOTV5zrmQNPHbmAcqTtGFI1xPlU4AbfXjco9z8RVd2F1NRVRk9In0wwXknlw4rxK7IXLaaFcfSr6laJWraLskN8QPSOaMCI2n98ckFd07f2XVywoApNtuI7+Oo13eF/JVJab66GjXOaddA6Fz0SMblq+YE3txUp2bsuk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4956.namprd10.prod.outlook.com (2603:10b6:610:c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 13:28:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 13:28:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
CC:     Chuck Lever <cel@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "BMT@zurich.ibm.com" <BMT@zurich.ibm.com>
Subject: Re: [PATCH v3 0/4] Handle ARPHRD_NONE devices for siw
Thread-Topic: [PATCH v3 0/4] Handle ARPHRD_NONE devices for siw
Thread-Index: AQHZnsibRR+G971lN0OTITy58rahs6+LxBYAgAAY1AA=
Date:   Thu, 15 Jun 2023 13:28:27 +0000
Message-ID: <387C9E7B-2C5F-4207-9C5A-A57CBF99D8FE@oracle.com>
References: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
 <ea05a59f-b13a-dfca-e7eb-4a873ea799ca@linux.dev>
In-Reply-To: <ea05a59f-b13a-dfca-e7eb-4a873ea799ca@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB4956:EE_
x-ms-office365-filtering-correlation-id: 78978516-1942-4336-0229-08db6da466dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Isv9AsfUt6q5WgbP2AzJBVS1NFtcdc8QSwjBAgPF0RPrE0XUvtuNn3+7dRR4LEg3o5FTz9rRAj/f8R4XTx8BMKM5nUX194yjhNUZqjvvjoReF4AeeZ4TpWA4rBHZZguvg+XIS8wHppZD6Tuw9Gd6+V0wODV3wzGyePzkoZFJIQXxeGQ4D+Fez+nJCZwYCeCIiYwN5htxp+Qm1fIEB1ZKH4Ji5ic732gJpwqPPjk0v2RZ2mTsG8MwkaD6CULKlXMxDmAu4jTgjQ+6Sag/xDWeZlxoc1wM4jbkPk424ytKQWHbYMdIe77Oxd41mQpE7mhrY4xusX/7N9eUWhUgjJMpCW7+MFaKJOLNOFLt0RkUXdpG1y7ZX292EuBZE5SUWd71j/NF+kemGPRRQuacs2bXak6BhLj301Pma33UdO+FHptPUxtXUNOmgzp+4ehLd3hjVM9Y9QGzP4O34AGPv8yrhNruSykbTEdXIp+v8997QYL7zLN6jXemYu8Bdzd89TYTAVljnbSHgPXFdosPrIJ6i8+URfOqMBh/6TQ7cm701Rnh6kcSbYpx8Rf6uLPaHiDalwPvDQnYt30eUFwFZb64Lik1/d4RkOOqiCk7E/wuOjSOkikxTM8vNdK9lIsri4I43LUAWKbQ4g3yqpxd9pSkPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(5660300002)(38100700002)(122000001)(2616005)(53546011)(6506007)(83380400001)(186003)(2906002)(6512007)(26005)(38070700005)(478600001)(66446008)(64756008)(66556008)(6916009)(66946007)(66476007)(316002)(33656002)(71200400001)(8936002)(6486002)(8676002)(41300700001)(86362001)(36756003)(76116006)(91956017)(4326008)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VitmQXZVV2hBNFlTOGZFcHlKN1ZoZFJRNHlLMmdIWHErYlJ3NVZTQ3g4YW9S?=
 =?utf-8?B?UEtrTE4zM2prY0dYa1lMemRwOFpMK2FtTDd4dmYzVXR5bGEwdStHT1IrUEdk?=
 =?utf-8?B?dW90L3VhL2kxVis1VGtCU3ZDRHJ4QlpKS2xaaFVOVzlOdXRzWlBRbTU4N21m?=
 =?utf-8?B?QklvMmhMNFpzREJiQUtHRmJMcG45Rm9HaDBvZm14T1JZU3p0ejhMN3AxS3hQ?=
 =?utf-8?B?T0sxcHdPYm1qeEhTMlkxMEpPeFIrbDhrakwvcWl0WnI3SnFDa2dFbFVReUdO?=
 =?utf-8?B?TTNaS2VlRzdFYjQ2OGpQaVBja1NGK3VManBNVUh4ODl0M2J4OHZIRzIwZ3hI?=
 =?utf-8?B?MWw5Y0JWc0pyMU5DSGJQQnVTUUV5TFlJVHBsNEN5Y1AwVlV2dEZYKzBVOG9E?=
 =?utf-8?B?V0htaGRMVWpEd1RiSENkUjlBakNHOW5iVGhhdTdkMWtwcjV5T2dES0hyUm8y?=
 =?utf-8?B?V0ZnMEhZSllrQnJjZE9KZHQwU29peUlmUDRmQ01zMXF2MEt4NDYxT3dGTTJZ?=
 =?utf-8?B?WkYyUmYzVFByK05SWXQzY0hFYzF2NHd0QzlqalAyVEdRckFFbG5rck9jSXZq?=
 =?utf-8?B?NHdWcXN6VzlSbXZYY1hIZmxoWkJtOXg1REI1ZkJJU2FZMnRXRkhSRFpIeFYr?=
 =?utf-8?B?UWtyMkJZSzhJL1hzTE90ZXgrc2RMbUdYRkxRZW4vUmZIT0ozeER0U2hieWFk?=
 =?utf-8?B?OEVKSTNxQkdza2l3end3d245ejZKcG9OQ2pPc2NoRUlObU5mMHRyLzM4U2U0?=
 =?utf-8?B?THJzU3FGSytDWFpkVll3aVdVaDBXYkE0a01RZXd4ZGFUNlBCRnNkaXNzQTZR?=
 =?utf-8?B?dnpLNFFzN09EcmRUallLSXBnMXhtQlFuaEcvdyszZlBJZnRWdjlZclk5Z2JE?=
 =?utf-8?B?SmFlbXdUdForTktwYTBSRHBrOEFUaTNvUGw0Nm01Q0dpbjBYYzIrUHM3aHJW?=
 =?utf-8?B?QkhWMG5qQUlRYTRKTnNpaGRUMExidU5kc2FXNkpBYzVZeURRZXZIRnBBakVx?=
 =?utf-8?B?STc4cFhqVnhlTWNkZU9ZNFdicnFWOHBSYkkxUzFhbGNBeWZiT1ZFS3ZaUE8r?=
 =?utf-8?B?eHFXSEhBaXF3U3REeEwrdzV4d1NOMzJZN3dGQ0g3V3dKTDFZOWRLM0dpdktr?=
 =?utf-8?B?MHdXVlMwd1IrNlpIMzI2NXdQRFlxZEFrSXNJT1cwb010SE9KUk5SVUE5aFZC?=
 =?utf-8?B?S3RQTnd1VlNuRGxuU3FHSThCL3h3aFQ2Smsvc0VTT0kvL25TVzRCN0dOek9H?=
 =?utf-8?B?SFNmdERmWmQyQVpMVldralBLcnhXaGZIUXJnY0NydHlTb1pLQkZxMTBIUEs4?=
 =?utf-8?B?TkRldHJyWGIxaGp6SmtyVkcxQU11YU5KcEN1dzJ4bjUyK0dySHZ6YUF3RzJh?=
 =?utf-8?B?VlNSeHBhUGpid1VYdlRSdHRPZ1ZHY1dzWDJsK3doaFBzZjdSYjlYSzVZWXBs?=
 =?utf-8?B?VFhnaE1BVFQzUm9Vb242SFo0VVJEd1R4V05QaW5ZUThYdWJQVTBFdGxVekZR?=
 =?utf-8?B?YUs1eWowMFc5RnBQWlFCYUViYTQ4ajVBMStEOEZ4b2gxNDNlMC9CYlYvS2l1?=
 =?utf-8?B?TVNOaGZ2dzFTZXFJdWtHY3crQUJ4blFCWDF3Vy9IejlWdW1LUDhWaFZWbElt?=
 =?utf-8?B?UzdsTldKRGlGY09ta05STmFuMlRNVHNsMWEyUHZnM3NpTXhpNnZaZlFkNGQ1?=
 =?utf-8?B?Y3hZOUh1TmRBckpkK2d6b0Y4dk1kWHRiZEhhdm8weXJaUEJwTHh1L1Fvcysx?=
 =?utf-8?B?b0xpcThaT1lyTkFVeTZWWnF0KzR2d09uQzRyNDNlU3BncDBqVVNZR0NkVTRk?=
 =?utf-8?B?UHo0TW80T2tXNElCTFpLaGNESTdVbFB6VGVQeUtlQzNmZ0ZDZ25uV2lFcmdj?=
 =?utf-8?B?Y0RBbUk4YkJnaUlTMDVqUG1oUGE4OWFBZWxVbE1tUDFWeDdoNG1XanMxS3RV?=
 =?utf-8?B?cEJDRjZwaDk1V0FFNE1zR1BySG9SblFZNXNVaUNKbHN5UFloU0NZR3lKT1Bi?=
 =?utf-8?B?YThCYVdNR1IrWEVwSFNpZStob0VjcjJxSXVReVZKSWFReVIreVJCNzZVOFNT?=
 =?utf-8?B?RDc2bW9wVnZ5MEVCSis1T0JYMEVtYVZWaUtUMnJLbnRZQnNwakxrQVozOGdE?=
 =?utf-8?B?ZkRZdTVabVFzMEJJUjRZMjRSL2FWbFFBOXkzRkRWVm5WMmlOWmlXTGxuS3d1?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <957AC2EF742D2E4EBC616FD92D865A39@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1Cj54YerrPjFWi19ZfWf+ezIqyeUx+AzqTT6jLOB5UrGMWbV1FZA87UFNVQTSqhavsYJ4l3ywsei7HvYI82KGSR638oah1i8+LL7mHhN7wbS7va3HjbI1Te9JxeW+hlhg9Fxx5c9URj4NlPolWOVbaEmLTJzeWXz8ImzouvZ6QNsflCtresxHG7j5TagY/9WoFlzDMyWE4i97Tlfadcs/ZgJG/OPtH3Kvm+xbzedvw5rB7EVRbPMjoTOm+VflgYPO/6NdtFhP9Umpsfh9W7zI1+W5t4ePTGqKN1ML1ikDVLVZm132obZT2sxAwJVK1Rhzd2DKGOyyRP9EHCYU4VnlCocMu1Q70P4Z3EOogKI0AIOE1lgeez6jRE0vc90NlrzuTbGXxTiJKazJoWavpFywnNydgUguWEIrr/9M7XB5qVqgDUq5G14T56MpDcwVnzOUsnpY2NS7b0WQoQH1gdNBP4zZB5kIdWj/GxZoG+RMSsP0GcU57yrsQMmp7SlvXcWPwBlNBrUlni913NFmPX4h/jXzIoRYM0Vl6TBIP6t2Y5YAJE4GJvR4vQ6mX/+jw/pRHE2P0mbaNYgDmlcGUzBte+i8NfI+T/0vmbCKhK54ouD0M4/UW3TT5Gm5yCT/CHm2QzzvEMPlkuQQkEtQjYraPhXIu15osqKc325LW36VIaQDAhLwpz2bO6NmInxbl6ytxFaP3zOl5w5I8jdd+3bFGLBkpBQ6Rp8fDlCi3ezsXD5QZRukKTexL1dgG1gkHV4UcqRzmPLqu6kjCxVm6TIzzeRbLaZTgLu2KEWYVQBcwG6zfSYT2FmyjKo8FNGx2ympzf+466m/Hy7aaRWwj+sJfsh1fsxLD16Z7hiLaR+aGjBGCgajUIDE910U3I7OlSgxciQtHtjP9XPpwIVGsG3ENSu+ocuKeA3QQFN2zAwIKg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78978516-1942-4336-0229-08db6da466dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 13:28:27.0538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZaGFzFWVQHfmYkNrluotUkFWnTvL92WKpEcSQvbfxO4mj3DBiEv3cUy3sgsSO8ewfbXOc/uNdoks2x+VToS7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_09,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150118
X-Proofpoint-ORIG-GUID: kffFuKpP7a1dYq75nFss7DyJ2Uhdyrtu
X-Proofpoint-GUID: kffFuKpP7a1dYq75nFss7DyJ2Uhdyrtu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gSnVuIDE1LCAyMDIzLCBhdCA3OjU5IEFNLCBaaHUgWWFuanVuIDx5YW5qdW4uemh1
QGxpbnV4LmRldj4gd3JvdGU6DQo+IA0KPiDlnKggMjAyMy82LzE0IDIyOjAwLCBDaHVjayBMZXZl
ciDlhpnpgZM6DQo+PiBIZXJlJ3MgYSBzZXJpZXMgdGhhdCBpbXBsZW1lbnRzIHN1cHBvcnQgZm9y
IHNpdyBvbiB0dW5uZWwgZGV2aWNlcywNCj4+IGJhc2VkIG9uIHN1Z2dlc3Rpb25zIGZyb20gSmFz
b24gR3VudGhvcnBlIGFuZCBUb20gVGFscGV5Lg0KPj4gVGhpcyBzZXJpZXMgZG9lcyBub3QgYWRk
cmVzcyBhIHNpbWlsYXIgaXNzdWUgd2l0aCByeGUgYmVjYXVzZSBSb0NFDQo+PiBHSUQgcmVzb2x1
dGlvbiBiZWhhdmVzIGRpZmZlcmVudGx5IHRoYW4gaXQgZG9lcyBmb3IgaVdBUlAgZGV2aWNlcy4N
Cj4+IEFuIGluZGVwZW5kZW50IHNvbHV0aW9uIGlzIGxpa2VseSB0byBiZSByZXF1aXJlZCBmb3Ig
cnhlLg0KPiANCj4gVGhhbmtzIGEgbG90IGZvciBsZXR0aW5nIG1lIGtub3cuDQoNCk9vb3BzLCBJ
IHNob3VsZCBoYXZlIENjJ2QgeW91IG9uIHRoaXMuIEkganVzdCBtaW5kbGVzc2x5IGNvcGllZCB0
aGUNCnRvL2NjIGZyb20gdGhlIHByZXZpb3VzIHZlcnNpb24uIEkgd2lsbCB0cnkgdG8gcmVtZW1i
ZXIgbmV4dCB0aW1lLg0KDQoNCj4gTG9vayBmb3J3YXJkIHRvIHRoZSBpbmRlcGVuZGVudCBzb2x1
dGlvbiBmb3IgcnhlLg0KPiANCj4gWmh1IFlhbmp1bg0KPiANCj4+IENoYW5nZXMgc2luY2UgdjI6
DQo+PiAtIFNwbGl0IGludG8gbXVsdGlwbGUgcGF0Y2hlcw0KPj4gLSBQcmUtaW5pdGlhbGl6ZSBn
aWRfYXR0cjo6bmRldiBmb3IgaVdBUlAgZGV2aWNlcw0KPj4gLS0tDQo+PiBDaHVjayBMZXZlciAo
NCk6DQo+PiAgICAgICBSRE1BL3NpdzogRmFicmljYXRlIGEgR0lEIG9uIHR1biBhbmQgbG9vcGJh
Y2sgZGV2aWNlcw0KPj4gICAgICAgUkRNQS9jb3JlOiBTZXQgZ2lkX2F0dHIubmRldiBmb3IgaVdB
UlAgZGV2aWNlcw0KPj4gICAgICAgUkRNQS9jbWE6IERlZHVwbGljYXRlIGVycm9yIGZsb3cgaW4g
Y21hX3ZhbGlkYXRlX3BvcnQoKQ0KPj4gICAgICAgUkRNQS9jbWE6IEF2b2lkIEdJRCBsb29rdXBz
IG9uIGlXQVJQIGRldmljZXMNCj4+ICBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jYWNoZS5jICAg
ICAgIHwgMTIgKysrKysrKysrKysrDQo+PiAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMg
ICAgICAgICB8IDI0ICsrKysrKysrKysrKysrKysrKystLS0tLQ0KPj4gIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9zaXcvc2l3LmggICAgICAgfCAgMSArDQo+PiAgZHJpdmVycy9pbmZpbmliYW5kL3N3
L3Npdy9zaXdfbWFpbi5jICB8IDIyICsrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4+ICBkcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jIHwgIDQgKystLQ0KPj4gIDUgZmlsZXMgY2hh
bmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+PiAtLQ0KPj4gQ2h1Y2sg
TGV2ZXINCj4gDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==
