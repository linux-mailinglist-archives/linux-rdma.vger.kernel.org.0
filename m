Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48DB62ED4A
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 06:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiKRFtJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 00:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRFtH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 00:49:07 -0500
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1970D10557
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 21:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668750546; x=1700286546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W3ljRh5dCiFqf+wP2Yt8RRo0rIbxbatxXlCTwiR+ZRM=;
  b=SodrvyNVuU+8eZQ3cVGS0qLaxIhZeCNKjXW75x/X1i0g9m1zskXypIGv
   fMNWHNlKLVwOSu8DADhd3VHJe4j37LP5JusE9iErlhQ0UhpOdf4pp06y9
   XejnsnhpUmHECupr48Tihh9CisOT0ENZzOurbPiAzZ5L1tZ3N55Z4I54J
   ycl7MbYnmFElCd45QYTwqY/Y4uupLCCVA1nkX5fXSexC0Sc8/RjoLz5TE
   Ptq6a8VHSK0Nns2O0PV9mGUPZIckYNsRQ9El1nlVPS0+9XTP9KLq7iy++
   dLF4zNHVsxLwrdw5hLXPeFaZr8ipto50ntV9snF58Tx+Gn6dpueGpZ0gb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="70763791"
X-IronPort-AV: E=Sophos;i="5.96,173,1665414000"; 
   d="scan'208";a="70763791"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 14:49:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsJE9YUYBiYtfEE/dIHKXYQqSvY5eraHQW0FYSl7KkeSAv6el95frgbl0W4luajwwLXfo1osTRd4Dfphi90/9sTSBClrEX2QBiJlNE+2ftVOfGQZF3+n1GbNm6pE4O7XryDSIsy2hoFEGWDj8qKUbIZS+yBeK5QNU7hiMPmlT58/Syv6teXTkd363YWdyNcW+S9gjTV93qUYKlCdVUPMyv/4llivXXELJg99RuiD73B7C6WR5OGoMwlvYBkgNSa3IoP2DtrCWcYcClvuK/YaejXScNvkW8Mhic9FgWMbj3zgXyfHjuvZyL1En8j1QUcKjadylZUMvAvOMBV5rumVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3ljRh5dCiFqf+wP2Yt8RRo0rIbxbatxXlCTwiR+ZRM=;
 b=eRvlvm2G8lygkatkg/sqAZPRm9JbYL7wnYYsGq5BvFGici6/D0Bq02pPIMTmxcVe9q+aL7xL6E2ACBdP5ZSdv1Tv7gQNQonzrWbJOqT3KpJhRhX6Z3Kvp7NM9LT9vBpnK2tW/KN2Tk7tBMRdky+pRCXccsPM0INIpWyCFgCv5AOin7Ji/DiLKWZ374wsYFuysh1fpv+7lL8vahKK4FL4K3EqgdwMUo4Z7Ay0lxhgsDcBP+/BSWeZrh011zPd/h7kFhK1vEb7AF1h4raPWY6hmlc7E5E5Ij4r/ihSZClEle31Inu5pKGEd7/TNsmED9oftZu/fFvBHlaIAXD94YO5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Fri, 18 Nov
 2022 05:48:58 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::38e9:4e9d:6868:3dd3]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::38e9:4e9d:6868:3dd3%6]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 05:48:58 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: RE: [RFC PATCH v2 1/7] IB/mlx5: Change
 ib_umem_odp_map_dma_single_page() to retain umem_mutex
Thread-Topic: [RFC PATCH v2 1/7] IB/mlx5: Change
 ib_umem_odp_map_dma_single_page() to retain umem_mutex
Thread-Index: AQHY9a9QHWh8k3BTQkKozhbPIb/whK5DI22AgAEISSA=
Date:   Fri, 18 Nov 2022 05:48:58 +0000
Message-ID: <TYCPR01MB84559855A5DB9871BCE964EDE5099@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <cover.1668157436.git.matsuda-daisuke@fujitsu.com>
 <b9974985069900c80b8ff9e6b0b0b346c1592910.1668157436.git.matsuda-daisuke@fujitsu.com>
 <47a000b6-8a5f-541f-809d-ad367f81669c@fujitsu.com>
In-Reply-To: <47a000b6-8a5f-541f-809d-ad367f81669c@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 8f3e2e5c015046b8ad6ddaedb38ed2eb
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTEtMThUMDU6NDg6?=
 =?utf-8?B?NTVaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0yZTIyNzY4ZC02ZmY5LTRhNDYt?=
 =?utf-8?B?YWY1YS0zNmU5Nzc2MTkzYzU7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|OS3PR01MB9499:EE_
x-ms-office365-filtering-correlation-id: c3df85b1-bbd0-4a59-ce39-08dac9289678
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FLRNfeYNozleJ8ExAHxvoHJRlgJuwunmwP5i88gJRIJq2EyRVQknoJy6qkrVZsDCxmI6sFYtVXfPtJ7bh7pqpyaPOdBLJC955dH9c3hdm2aWksVEs9TkqTwyY9d0uWJ8KhkrOlOWvgeO9G3VUeT/ioWkcWK6dGAVTPKCpydzL/YxSbAMqXfVZeh08JsUOJCO0vE3K+4tsyC5+r/fHBZ7fxV7R0NgcxbaWkY+io6iJeM37pYCSXlaWNPmkdeAZ5delYogFO4A7dqAbH7eDjK0xeyXDnlVZKsdRf5oN5Zan1mPAKryHETktjAgYPqxdKjMyxGMBwKWGCKoofmK0JkUN9UyyDVyEojfVXpcG/ofikM3G+mVu91CQpGwcToUEu/ZQONoWY2IXx+dTaB7QfTXpBXR8qEtbDap8BVl9L9pfYrEqZpQjQCRVCiqaMyCUMgQAEENTDn5XVFdzAGhXCecj64aCD9kkPCQuNGjT8iUApAGttBkHeQB2UlmW4WqpX3TEunGTP1t9yyzgmcskhTzfo/KJomss15yBkL2wcG7gZCdTzq40HMTrW9BTNbtZCvEEvz+RjLXDSfrWJZqJhUtZYP8+JF4Xw1Wfq89tl4Y0qdbNnOr++AZND+dnlXmYO3sqQYg1A7cFmFhLUdoK23JTl30vn+3uYrtMU6BKGWM8xkdJ40VXQseihGfHBsj7gAEqJIfgNYgbpBoU/mzvIvSyqvQQjTv/F3W/7tW4HscI9ljRxbwd1XUofgXVHZ8PB5ZyM7JQ8tafCHX/FEmiGxdHMTaNM5Jp5dVgHVRQKEuz3lRVoMMY4Oav0o8xCOI/nBu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(1590799012)(451199015)(1580799009)(2906002)(64756008)(5660300002)(186003)(8936002)(41300700001)(52536014)(4326008)(66476007)(33656002)(66556008)(83380400001)(66946007)(86362001)(66446008)(8676002)(76116006)(316002)(54906003)(110136005)(107886003)(38070700005)(71200400001)(9686003)(966005)(82960400001)(85182001)(38100700002)(26005)(6506007)(53546011)(55016003)(478600001)(7696005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0hkRE96SG1NK05mRHRJNWwxWHUzTEdXaVJ0RTRpSWlZWTNTNUxWQ2RuWEh5?=
 =?utf-8?B?M0Zlbm5jbW5FNkowUXVISVNnODhhMVhRRmQ5bGNXc0pjN2JJcmZyT3kvN25m?=
 =?utf-8?B?NEFSMVZLS3lwUmtmSE5JWmk0azlSeDZUcWdlYTRsU1o1YVNieHF6WEN2czN2?=
 =?utf-8?B?Y1FwRFRQVjZob3BwM3lGSVBnNlRYTHlhdDh3OEVnUWhMNmhoZk0xZkJQajdj?=
 =?utf-8?B?cEgweks5Y2N0dGRoYVNuZmdJdWhGUGptSGNKSW1SdGxpQXNYSDlQU2JweHRJ?=
 =?utf-8?B?aFRZemVNMWM5cnVzdWFneCtWcDd5SDNUcWFMaTRLNmJOWURVdkRmYnpkY1N3?=
 =?utf-8?B?SlduejBJV3o5ODd1VmZmd01rWkZ0Yy9HRnRUL3N1amRJdWQ0OGVRVVFOTWxo?=
 =?utf-8?B?NWRPdThIaFl5cGdUaEtwVGdLWTFGeGlUSUVnUndOamNMQ0g1NzMydUpGbUFm?=
 =?utf-8?B?L2hFRUd1RjM0Wi9PSEFPTkpsUS9qMXVUS1ZpRGkyTEFFa043RTN5OU85a1V0?=
 =?utf-8?B?Z0dKMjYwNHBwNGJRSCtVNDE0cll2TkVIdGJHT29NeHlSMHFFdCszbDRjQllV?=
 =?utf-8?B?aXRmS0pjU0YzK0lJLzhuNjdla1ZPNFM1cDN2dTMyN1FHNmhaQkZ3M25MZHFH?=
 =?utf-8?B?QW1BNnhEcTF1dWxCY1d2cGJrOFNxdDBjTG9iLzd4U2UzSHRBb1BWZlhWNkdG?=
 =?utf-8?B?VTY0RnQyQlBlTnlGWWVhbFJjZUp0dHR5RVd1emw5endOakxiVldNM3dxUkIv?=
 =?utf-8?B?N1ZOSjgxaVVlTms4anNialU5bFRDd2JOZS9vMjV6aDdmR0RycWlGMStyOTND?=
 =?utf-8?B?OVcvZEpGZ0E3V1NCNXlTTlU2cUo3c1VvTitCc0UzSVdET2U4OStTUUF3bERx?=
 =?utf-8?B?SFV3VkJVRjE2K0tNd3BuelQxc2F1ZSt6RzFQNGYyeXFIVTlubmZyQzc0UU1i?=
 =?utf-8?B?NkxoTnprNG9PaFpFMmpMNTZpSjhpQmF4SGtwWlpPQlZqRFpscUhrdWJxekpG?=
 =?utf-8?B?NzMwc0VDcEdYbmVYWSs5UEMvQnpZYVM0K0hQTkNiZVdKWHlqc09HSXRELzhh?=
 =?utf-8?B?U1JsLzhSV1VCcHdqeUlFTU9qenIyNkpyUEYvWHFMZTdodHQyeFYxbm5hK0Qv?=
 =?utf-8?B?Y1ltcUx0dVpvaExKV2lHYkZTbXp0RUJUZW1jeDlJUFhQLzh6WWpDQkRnTnZY?=
 =?utf-8?B?dzM4MFljV0o2TDQxcC9UaWJ2YUltRFRxNGJST3V0bUlxd0VGM2JaVnQrSThO?=
 =?utf-8?B?WkprY3hWbkdlaWNML1l6WndyMytmc0xNNmJ0a09ObnFUdnErTzdBcVFwWStD?=
 =?utf-8?B?by93VklyS3hCRktFUUpBb2E3ZDhtbGl5MmNSSERDSHMwRTloRFdpQTQ0N1JE?=
 =?utf-8?B?a1BBRVNPaHMyV1JDRllxenhlV2hEeUpLaGVTdytOSHdkOUtJRHM5VVFSVGFV?=
 =?utf-8?B?ckFHOWFOSCszSjloS0NWdDlCNGthWjdld1NlcHRqelEyU3lpRENQMXNFczlv?=
 =?utf-8?B?YU9vMHZ0NGFINnd2S3pxQzlSRnM1cjhwb212M09qMFFSbmp0bkhQcm5UV2d3?=
 =?utf-8?B?eEx4VkF6SlI3eld6ZGZZMzh6TW5OWk4yOEN2K3JNNnNxSkl4aHdlcXdjOWVy?=
 =?utf-8?B?ZmpCczdNbkRlQVA5SlloczJZWDh0VW5TcHZWaE5tck1CN216SGwrT1ZhU1pM?=
 =?utf-8?B?M1FaL2ZUMWtXNTRRelBSMmxYK2kyUVRZakVMSllGZUpWMUVOaFV6UXJ6djJM?=
 =?utf-8?B?Rkd6citUUVg3Z1BibkZINUFab3dRd1NSdkF0RVRjeS9TM3U3YVRVSHNBNjVJ?=
 =?utf-8?B?amJxZzBrbndaeFY0aG8rTXNxSjYwRnRuZjd6dWMxSXdEVnBBZ1lzbVdHQW9H?=
 =?utf-8?B?eGVaOXRyY2x0TVZSWVUycVYwV1VjaDh1T0N3OU1zT0kwQnVtSUF3NmZoeDN5?=
 =?utf-8?B?R1pwbTBEcVZ6aUY4OVB6Y25tQ1UwU0I4VnM5RHRCYU5uaFRVTTd2NmdqVDNt?=
 =?utf-8?B?K2xtVC8vWXo1K1NCQk1iU3Eyb3EwVkdyNFJpcm9kd1pQd1QyODBPOHVXMi85?=
 =?utf-8?B?OVJ2ZStPOGpNZkxmcEc0N043bm52TXNHL2JTU3RqYkI4b0VkNDE5TGNrc0k2?=
 =?utf-8?B?Ti95eFBncXJpMXZhbkJCUmhaY20yakVhbEswUDBCN2pBK3l1Y3UrZVUzWWEr?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NlN4WnRNbGhzU1hTaDNCaThmNDVFU09YdE50T081NlRnVWszSG1oYldLbHZN?=
 =?utf-8?B?b0luZHU1QmNQYzdtMFpuY2tKbU1RRlRGdklxT2d1YkhQeHFSVXFGT013U01o?=
 =?utf-8?B?ZmN0V2NsdW45M25tb2o2OEZKTjBnSlV5YUx2cTRMeVJnQWsyQkdTZ0pCYkRs?=
 =?utf-8?B?QXY0djZNYkl2S09CZDlkdXVtWElmNklmVWNGeCtuY2kwT1M2NW92NnhCWG84?=
 =?utf-8?B?Y2RueGxjeHk0THFUTzAyM0ZodFhaSW5pcUZzZEtmK0JoNEVoZ1ptaXpPc3M2?=
 =?utf-8?B?RU1aRnVzY21RMWovZUk3RVZVSEluRmVKcmg0eU5GRnkrQXpFVXhmN08rVU02?=
 =?utf-8?B?K3Q5YzdNSVdjYXhCTFpNaUZrajRMZjBta2Z6Mm5rVFhrT2IrQ2R4cVBuN3Aw?=
 =?utf-8?B?UHVXdmNWU2Y1RjErVHNFZnlWZHFrbzVXeGlYUVlYYS9sMUJUSkF0OEZNOXUz?=
 =?utf-8?B?Wkw0TGdxNkxUYmFtbndZQjJod216bmZYU2lnZy9ZdEs1eGpFenJCNkVvZHNy?=
 =?utf-8?B?TmVPeVdzV1BjaFk2azB1dTdTWTlDbW1xcE1Ldko2UEtJM1FSanROK0tWZDF3?=
 =?utf-8?B?NEh0VVUrRklTdFcyVEEySnJ2MWh5ODNDcHQvaVZFZWFLdjNXVnVENTdLd3Ju?=
 =?utf-8?B?cmFnclBmL3Mya0EzNUFmM0Z5RGI1UHI4LzRmeDU5SmhGZHl6UnltSndQRmlL?=
 =?utf-8?B?QmNZK2ozSm02ZGtDSHFqakwyTGs3azlCQVlYWkQweWlwNzM5S2p3S1NyMytR?=
 =?utf-8?B?aXlFSGM4bjFsRk4reW90OCt2OU5xRlpXMDV0ZE9JRzRTUlovRERkd0hDRmJy?=
 =?utf-8?B?Y0lydy9UdUZUUFZxaDloNldyaU5WamRVWVlrTTZYVVNoREowUzhiRXd3ckha?=
 =?utf-8?B?SlBRMDFKOHUweUhHbFd1cmpqa0svd2g3YW5pTlRZZXBBdTQzUU44VDJLdnZO?=
 =?utf-8?B?ell3elNIREphOEdYRDJVWkJmNEYwUU1xVERvN0tQWGVIdlJxbFpwNmUrblRp?=
 =?utf-8?B?RDMzbHA1bkVYaVpLM2Z6NExyRUZ6UVB0dVBMNjVjUGRHMDVSUXYrSlV0OGhj?=
 =?utf-8?B?UlpRMllQalRVN01zVDloclJFbVhCcVFEKzFvWXZRMmxncGVRR1F0c0JxdDE3?=
 =?utf-8?B?bGREeWdzSVFxSXhpb3o4SDRFMzI2MUpUdnNYYWtaMlYzQWNwQ1lrNGpoczZk?=
 =?utf-8?B?Q3FmS3N3OHhFSWRvcFp3U3J2YUJYZDB0dnFENGZLalRxeWk4OWhYQWdsMERw?=
 =?utf-8?B?U3g0Z0JRTlZsenBTKythMk54NHRzeTArajBFUE53ZDRYRXpKdz09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3df85b1-bbd0-4a59-ce39-08dac9289678
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 05:48:58.6408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyTA4jtEntlv92XapaEAiBSW244GCUFUBCFF5Qvwkmo8CYyIjHoDPaNu4P0AsvGRGYwZtGZ8gFIDbiLrAevPnUAtwK58+I+BtJCIh0gOOJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9499
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVGh1LCBOb3YgMTcsIDIwMjIgMTA6MjEgUE0gTGksIFpoaWppYW4gd3JvdGU6DQo+IE9uIDEx
LzExLzIwMjIgMTc6MjIsIERhaXN1a2UgTWF0c3VkYSB3cm90ZToNCj4gPiBpYl91bWVtX29kcF9t
YXBfZG1hX3NpbmdsZV9wYWdlKCksIHdoaWNoIGhhcyBiZWVuIHVzZWQgb25seSBieSB0aGUgbWx4
NQ0KPiA+IGRyaXZlciwgaG9sZHMgdW1lbV9tdXRleCBvbiBzdWNjZXNzIGFuZCByZWxlYXNlcyBv
biBmYWlsdXJlLiBUaGlzDQo+ID4gYmVoYXZpb3IgaXMgbm90IGNvbnZlbmllbnQgZm9yIG90aGVy
IGRyaXZlcnMgdG8gdXNlIGl0LCBzbyBjaGFuZ2UgaXQgdG8NCj4gPiBhbHdheXMgcmV0YWluIG11
dGV4IG9uIHJldHVybi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhaXN1a2UgTWF0c3VkYSA8
bWF0c3VkYS1kYWlzdWtlQGZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pbmZp
bmliYW5kL2NvcmUvdW1lbV9vZHAuYyB8IDggKysrLS0tLS0NCj4gPiAgIGRyaXZlcnMvaW5maW5p
YmFuZC9ody9tbHg1L29kcC5jICAgfCA0ICsrKy0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW5maW5pYmFuZC9jb3JlL3VtZW1fb2RwLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS91
bWVtX29kcC5jDQo+ID4gaW5kZXggZTlmYTIyZDMxYzIzLi40OWRhNjczNWY3YzggMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdW1lbV9vZHAuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9jb3JlL3VtZW1fb2RwLmMNCj4gPiBAQCAtMzI4LDggKzMyOCw4IEBA
IHN0YXRpYyBpbnQgaWJfdW1lbV9vZHBfbWFwX2RtYV9zaW5nbGVfcGFnZSgNCj4gPiAgICAqDQo+
ID4gICAgKiBNYXBzIHRoZSByYW5nZSBwYXNzZWQgaW4gdGhlIGFyZ3VtZW50IHRvIERNQSBhZGRy
ZXNzZXMuDQo+ID4gICAgKiBUaGUgRE1BIGFkZHJlc3NlcyBvZiB0aGUgbWFwcGVkIHBhZ2VzIGlz
IHVwZGF0ZWQgaW4gdW1lbV9vZHAtPmRtYV9saXN0Lg0KPiA+IC0gKiBVcG9uIHN1Y2Nlc3MgdGhl
IE9EUCBNUiB3aWxsIGJlIGxvY2tlZCB0byBsZXQgY2FsbGVyIGNvbXBsZXRlIGl0cyBkZXZpY2UN
Cj4gPiAtICogcGFnZSB0YWJsZSB1cGRhdGUuDQo+ID4gKyAqIFRoZSB1bWVtIG11dGV4IGlzIGxv
Y2tlZCBpbiB0aGlzIGZ1bmN0aW9uLiBDYWxsZXJzIGFyZSByZXNwb25zaWJsZSBmb3INCj4gPiAr
ICogcmVsZWFzaW5nIHRoZSBsb2NrLg0KPiA+ICAgICoNCj4gDQo+IA0KPiA+ICAgICogUmV0dXJu
cyB0aGUgbnVtYmVyIG9mIHBhZ2VzIG1hcHBlZCBpbiBzdWNjZXNzLCBuZWdhdGl2ZSBlcnJvciBj
b2RlDQo+ID4gICAgKiBmb3IgZmFpbHVyZS4NCj4gPiBAQCAtNDUzLDExICs0NTMsOSBAQCBpbnQg
aWJfdW1lbV9vZHBfbWFwX2RtYV9hbmRfbG9jayhzdHJ1Y3QgaWJfdW1lbV9vZHAgKnVtZW1fb2Rw
LCB1NjQgdXNlcl92aXJ0LA0KPiA+ICAgCQkJYnJlYWs7DQo+ID4gICAJCX0NCj4gPiAgIAl9DQo+
ID4gLQkvKiB1cG9uIHN1Y2Nlc3MgbG9jayBzaG91bGQgc3RheSBvbiBob2xkIGZvciB0aGUgY2Fs
bGVlICovDQo+ID4gKw0KPiA+ICAgCWlmICghcmV0KQ0KPiA+ICAgCQlyZXQgPSBkbWFfaW5kZXgg
LSBzdGFydF9pZHg7DQo+ID4gLQllbHNlDQo+ID4gLQkJbXV0ZXhfdW5sb2NrKCZ1bWVtX29kcC0+
dW1lbV9tdXRleCk7DQo+ID4NCj4gPiAgIG91dF9wdXRfbW06DQo+ID4gICAJbW1wdXRfYXN5bmMo
b3duaW5nX21tKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUv
b2RwLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9vZHAuYw0KPiA+IGluZGV4IGJjOTc5
NTg4MThiYi4uYTBkZTI3NjUxNTg2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9ody9tbHg1L29kcC5jDQo+ID4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvb2Rw
LmMNCj4gPiBAQCAtNTcyLDggKzU3MiwxMCBAQCBzdGF0aWMgaW50IHBhZ2VmYXVsdF9yZWFsX21y
KHN0cnVjdCBtbHg1X2liX21yICptciwgc3RydWN0IGliX3VtZW1fb2RwICpvZHAsDQo+ID4gICAJ
CWFjY2Vzc19tYXNrIHw9IE9EUF9XUklURV9BTExPV0VEX0JJVDsNCj4gPg0KPiA+ICAgCW5wID0g
aWJfdW1lbV9vZHBfbWFwX2RtYV9hbmRfbG9jayhvZHAsIHVzZXJfdmEsIGJjbnQsIGFjY2Vzc19t
YXNrLCBmYXVsdCk7DQo+ID4gLQlpZiAobnAgPCAwKQ0KPiA+ICsJaWYgKG5wIDwgMCkgew0KPiA+
ICsJCW11dGV4X3VubG9jaygmb2RwLT51bWVtX211dGV4KTsNCj4gPiAgIAkJcmV0dXJuIG5wOw0K
PiA+ICsJfQ0KPiANCj4gcmVmZXIgdG8gdGhlIGNvbW1lbnRzIG9mIGliX3VtZW1fb2RwX21hcF9k
bWFfYW5kX2xvY2s6DQo+IDMzNCAgKiBSZXR1cm5zIHRoZSBudW1iZXIgb2YgcGFnZXMgbWFwcGVk
IGluIHN1Y2Nlc3MsIG5lZ2F0aXZlIGVycm9yDQo+IGNvZGUNCj4gMzM1ICAqIGZvciBmYWlsdXJl
Lg0KPiANCj4gSSBkb24ndCB0aGluayBpdCdzIGNvcnJlY3QgdG8gcmVsZWFzZSB0aGUgbG9jayBp
biBhbGwgZmFpbHVyZSBjYXNlLCBmb3INCj4gZXhhbXBsZSB3aGVuIGl0IHJlYWNoZXMgYmVsb3cg
ZXJyb3IgcGF0aC4NCg0KVGhhbmsgeW91LiBUaGF0J3MgY2VydGFpbmx5IHRydWUuIEkgd2lsbCBm
aXggdGhpcyBpbiB2My4NClByb2JhYmx5IEkgd2lsbCBkcm9wIHRoaXMgcGF0Y2ggYW5kIG1ha2Ug
Y2hhbmdlcyBvbiByeGUgc2lkZSBpbnN0ZWFkLg0KDQo+IA0KPiAzNDYgaW50IGliX3VtZW1fb2Rw
X21hcF9kbWFfYW5kX2xvY2soc3RydWN0IGliX3VtZW1fb2RwICp1bWVtX29kcCwgdTY0DQo+IHVz
ZXJfdmlydCwNCj4gMzQ3ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU2NCBiY250
LCB1NjQgYWNjZXNzX21hc2ssIGJvb2wNCj4gZmF1bHQpDQo+IDM0OCAgICAgICAgICAgICAgICAg
ICAgICAgICBfX2FjcXVpcmVzKCZ1bWVtX29kcC0+dW1lbV9tdXRleCkNCj4gDQo+IDM0OSB7DQo+
IA0KPiAzNTAgICAgICAgICBzdHJ1Y3QgdGFza19zdHJ1Y3QgKm93bmluZ19wcm9jZXNzICA9IE5V
TEw7DQo+IA0KPiAzNTEgICAgICAgICBzdHJ1Y3QgbW1fc3RydWN0ICpvd25pbmdfbW0gPSB1bWVt
X29kcC0+dW1lbS5vd25pbmdfbW07DQo+IA0KPiAzNTIgICAgICAgICBpbnQgcGZuX2luZGV4LCBk
bWFfaW5kZXgsIHJldCA9IDAsIHN0YXJ0X2lkeDsNCj4gDQo+IDM1MyAgICAgICAgIHVuc2lnbmVk
IGludCBwYWdlX3NoaWZ0LCBobW1fb3JkZXIsIHBmbl9zdGFydF9pZHg7DQo+IA0KPiAzNTQgICAg
ICAgICB1bnNpZ25lZCBsb25nIG51bV9wZm5zLCBjdXJyZW50X3NlcTsNCj4gDQo+IDM1NSAgICAg
ICAgIHN0cnVjdCBobW1fcmFuZ2UgcmFuZ2UgPSB7fTsNCj4gDQo+IDM1NiAgICAgICAgIHVuc2ln
bmVkIGxvbmcgdGltZW91dDsNCj4gDQo+IDM1Nw0KPiANCj4gMzU4ICAgICAgICAgaWYgKGFjY2Vz
c19tYXNrID09IDApDQo+IA0KPiAzNTkgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOyAg
IDw8PDw8ICAgbm8gbG9jayBpcyBob2xkIHlldA0KPiANCj4gMzYwDQo+IA0KPiAzNjEgICAgICAg
ICBpZiAodXNlcl92aXJ0IDwgaWJfdW1lbV9zdGFydCh1bWVtX29kcCkgfHwNCj4gDQo+IDM2MiAg
ICAgICAgICAgICB1c2VyX3ZpcnQgKyBiY250ID4gaWJfdW1lbV9lbmQodW1lbV9vZHApKQ0KPiAN
Cj4gMzYzICAgICAgICAgICAgICAgICByZXR1cm4gLUVGQVVMVDsgICA8PDw8PCAgIG5vIGxvY2sg
aXMgaG9sZCB5ZXQNCj4gDQo+IA0KPiBGdXJ0aGVyIG1vcmUsIHlvdSBjaGFuZ2VkIHB1YmxpYyBB
UEkncyB0aGUgYmVoYXZpb3IsIGRvIGl0IG1hdHRlciBmb3INCj4gb3RoZXIgb3V0LW9mLXRyZWUg
ZHJpdmVycyB3aGljaCBpcyB1c2luZyBpdCwgaSdtIG5vdCBmYW1pbGlhciB3aXRoIHRoaXMsDQo+
IG1heWJlIGtlcm5lbCBoYXMgbm8gcmVzdHJpY3Rpb24gb24gaXQgPw0KDQpZZXMsIHRoZXkgYXJl
IGp1c3QgbGVmdCBiZWhpbmQuIFRoZSBkZXZlbG9wZXJzIGhhdmUgdG8gbW9kaWZ5IHRoZSBkcml2
ZXINCmJ5IHRoZW1zZWx2ZXMgaWYgdGhleSB3YW50IHRvIGtlZXAgaXQgY29tcGF0aWJsZSB3aXRo
IHRoZSB1cHN0cmVhbS4NCkkgdGhpbmsgdGhpcyBpcyBvbmUgb2YgdGhlIGdlbmVyYWwgcmVhc29u
cyB3aHkgY29tcGFuaWVzIGNvbnRyaWJ1dGUNCnRoZWlyIHdvcmtzIHRvIE9TUyBjb21tdW5pdGll
cy4gVGhleSBjYW4gbG93ZXIgdGhlIGNvc3Qgb2YgbWFpbnRhaW5pbmcNCnRoZWlyIHNvZnR3YXJl
IHdoaWxlIGdldHRpbmcgYmVuZWZpdHMgZnJvbSBuZXcgZmVhdHVyZXMuDQoNCkNmLiBUaGUgTGlu
dXggS2VybmVsIERyaXZlciBJbnRlcmZhY2UNCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0
bWwvbGF0ZXN0L3Byb2Nlc3Mvc3RhYmxlLWFwaS1ub25zZW5zZS5odG1sDQoNClRoYW5rcywNCkRh
aXN1a2UNCg0KPiANCj4gDQo+ID4NCj4gPiAgIAkvKg0KPiA+ICAgCSAqIE5vIG5lZWQgdG8gY2hl
Y2sgd2hldGhlciB0aGUgTVRUcyByZWFsbHkgYmVsb25nIHRvIHRoaXMgTVIsIHNpbmNlDQo=
