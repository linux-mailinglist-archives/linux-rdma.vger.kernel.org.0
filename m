Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8D62B16A
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 03:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKPCj1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 21:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKPCj0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 21:39:26 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C4BC33;
        Tue, 15 Nov 2022 18:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668566364; x=1700102364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0Ykdn26ZCWwHNOqjEzjAyIpUm5Qn7B4ofOPgNpvkfac=;
  b=dk+3gJLBtFijqM4KFa/x1LL+B8S+Cx6So+MwZHbJ3+arJNtovC9/XYMv
   xAs5vIi+w5PkpqxaVg/GkugF5j1BHfu5BXYgPCTJYwOaFHoyMLM4kHRcF
   PJf9K9UjFQBl+HJcMGTitfpA7/8SZZ7F9SNl82ftF1ZTTYQr8BvRtG/Hk
   NUDsvnvQ75SOK8CqykoCuF7zUqhyA72EyqFN6+6kr1vkRxlWZqOdu35i9
   ghw5uOt9E5ZCtMZB8azUo/pC8MNPaLt1PlDQ9FNfDSLaVJICK0RQN4d63
   TO0AgDqmazOOA5xflvpLGpSL1bmjCSXdy4L5Cfo6MuchDQ247IYo8mB6P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="78190870"
X-IronPort-AV: E=Sophos;i="5.96,167,1665414000"; 
   d="scan'208";a="78190870"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 11:39:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGbZK2ss5q1lEP6Tg7hCfwaLlSCZlSc3sNChaJBhr184lwojGt1MJk644sYA18Iyupd0r76tNLJFxRmY/U4eCGmM1UXbOUXjh0ojl8iLPjfctdIhRC1nppOOTj7Sfl7SW76jJXxHnX/r1rFrF5RHgd0+k0gNymzFFhUut0Vdp0WXmL36zg5hBayihuuRc/Vh6lYrImXRWdRXk3nMPnD1+1sMSLceXxvkuOS86UOyF8FiG8LVO3WzedjUhLIKvXRCdY0T3NFHLw9MpVMIWIn5DLVfmoouCxnbIkkoa6Nko6hOKegLF4of4ALZFKctFAnIhdf1YleQsaHRKMVMhz20Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ykdn26ZCWwHNOqjEzjAyIpUm5Qn7B4ofOPgNpvkfac=;
 b=mtt78Jajcj9b0ctYc+n13ORGpwIKtcusS/K+zN5WF+FrWlyRHAuxXMZVaEmdUF/LLyyiAZcrgDNqL39d09F4GxhcjdUBFL8RGnKYnsqF1UtOBPxk7EWlDBHnzlDDsn7rmYfIxDZzAnFY0oydV8qVbDX6O0iXYRwCjoapl4owVprwAKgG/GBW3N1NnsiGq8epeIOSVaR6dXTR+Wj07TByqF982G7I2q6ygygUJqtZB4fjVvp8RBqvb9XPcuuCPXVzjX4pMBD8FpSeSHkYUYXuPdRksHj5bUsZFf6zoys/Ey380CNWTvrMFiktS8Y1EUeTGdDmRdMgOkHJNHTWTcNFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OSZPR01MB9379.jpnprd01.prod.outlook.com
 (2603:1096:604:1d5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 02:39:15 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::4416:432d:2c36:a276]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::4416:432d:2c36:a276%5]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 02:39:15 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix mr->map double free
Thread-Topic: [PATCH for-next v2] RDMA/rxe: Fix mr->map double free
Thread-Index: AQHY7AySkBR0ibnAqkG24ae0Du51mK5Ax60AgAApcYA=
Date:   Wed, 16 Nov 2022 02:39:14 +0000
Message-ID: <e8490cd3-36d1-3471-bb18-ba8d0c9d4aac@fujitsu.com>
References: <1667099073-2-1-git-send-email-lizhijian@fujitsu.com>
 <c1fa0a0c-d8f3-f6c4-7964-3bb31ac936ff@linux.dev>
In-Reply-To: <c1fa0a0c-d8f3-f6c4-7964-3bb31ac936ff@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OSZPR01MB9379:EE_
x-ms-office365-filtering-correlation-id: 8733f10a-f99f-4a51-7184-08dac77bc0a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6foYHYPFM+kvMttvboKLzZORhqD18ops8RGguHXwsqE65MPm9zwFJ+Y8DYKIBDgUMEbF5k+zRovec1juNQx72sX++/WbToT8rU+pFh1xCqUn5I9ceOApYfBo8yao93YoLUld3qpBESQIEUKyE01NlnmXRbU9LbQDGLDdmipvBD2eKyrNdsAbvUpKQrf6uCIW91QO5iqWlpsCAEL444G1xugk+UMmLlsVV0gzhG8SLkFX6m+x70SoR6eCJ/uOpGb+Bd174EA8LLLijazjbuUrTrBQv10+Wl6qFgcTCzS2OpJADI3lE3d/Hp6qOtkMrNKafOIRNYASxcT8sOxipKfAu6vEt/epwzzKNP2aZoU6g7U76oQ87+ACxFYjbHxHMoGbsdLNpA6hH23fvmfKwjd8qFVWygNvgr7yYuNcuYK6Uc6Jo4cvHIrVjjCSptVtOQbHLlz6+2Q/crqp/PwuHgvwZ5i8NB0Lzh28l8dgCKBnKP1Re66PjqSRmbLAet6AFwb/Rm4QdAqfSNCt007oP08lQTwCBwAH0hoc1mKBWg5726wtRYNDngYaA01gkXW+3lyy47pmYvHlEdcf3sWzBpuF57QDNVKYdZjYuN/OeXx+ysIQ+bDx+6k+HnWCb4Wms9URi4Zg5zBzpKctNCFrbsbwFy5zLBYT+2JuLD9Co2IHtudiBUjdAij7bKexdR6jN4ERT/d7jwakcLTfXFAybT6jbPFJVvy6EzxQEfJadHcBn/JlAYKlo2Ok2j/RayL4ne65+BqTFsQ3frA/tTPujq/8XVStUFj+aTJXwIn+TMBgwViBLpr2vnOLQRD6LblJvV7AmmweTQhrjqCvuHejIRMmT6RDDwD80WRf3aqcMC2oA9g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(1590799012)(2906002)(1580799009)(31686004)(31696002)(66476007)(41300700001)(66446008)(2616005)(66946007)(36756003)(85182001)(76116006)(66556008)(91956017)(86362001)(122000001)(54906003)(53546011)(38100700002)(83380400001)(5660300002)(110136005)(6506007)(38070700005)(82960400001)(186003)(8676002)(64756008)(316002)(8936002)(6486002)(6512007)(4326008)(71200400001)(478600001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkxPMjArdEo2eDBBRnZ5TjhZdnlJa2Y1YTBVOUlsVkF3SVRHTE1tYW9XVGNt?=
 =?utf-8?B?K3BvdWtrWk5SaWlZTDZqa0tuTlJmS04xWFNoaTJMOStJblQyRmpmSmtTTFpX?=
 =?utf-8?B?Z2h4SEw1ekkvN0s2enNmU0ljbG9lYVdWZEd3Z3EzbnptMVBOV0ZmeEZkc1J4?=
 =?utf-8?B?NGJFZHBPNENiSkFtdm5SckpMMDk2Vm95b3Z6RzRyZ0g1RWl5ZWZsM0hkMVVk?=
 =?utf-8?B?dG1RRDN3ckZjU0lUYWJQeEtiOFZtTUxjRExPK1RxdEFFcmtMQXQrWkpESFM5?=
 =?utf-8?B?REp0TkRMSW4zeDNKQ2laVTV4ZVlWZGlqazFGVVZjMWszOTBmRHpCTGhRNXRv?=
 =?utf-8?B?enRqaWNuUGxPb1JGeUNCVDY2NzhnSE9oNHM5dnBhVExqaFFGemJSYkU1RTZI?=
 =?utf-8?B?YmZJaHhkSzBMSHFsOTBaQ2JqRUk4eUZuK052eUl0aXVPLzFadEJaeGU0S3lh?=
 =?utf-8?B?RTlhb0xVRlVIaUNReFVmNy90VGtwM2xndFFTZy9XU2UvbThKbklrUkE0WVN0?=
 =?utf-8?B?VzBlZnVpRDl2cHdTVXhTNUFoc3RXYkdZSmNJS2luMThSRmZQM3hBbElESFBC?=
 =?utf-8?B?UHlTWkEzSlBFaEZwSnFZMEhSeEQvbDBLRzFIbGpodnFqNWRJL01MaTBmVVQ0?=
 =?utf-8?B?Uk1Qamlla0g1WDZiUURHN0FnMlN1c0lNOTNWeGhuYVY2dXVTODJranI3VHd2?=
 =?utf-8?B?YmJ4dDVlVVRIQlpoVFR1WU4rYjM4WFhBVFl5dkZuRGJyV1RJUENtTWJiL3dt?=
 =?utf-8?B?TjBtc0d6ZWE4UkRUd3dBK1E4M09OOXBZVWRuMzFiYk9Mdm02UERJTHk5N2U2?=
 =?utf-8?B?WjhKMndYWVU5SFNXL0NDMDh6a1NObFBsaDFKTWw2ckM3QXMvczV1aHYvMVpS?=
 =?utf-8?B?dmZycndDY3FXdTRkaEhrK2RlMk1TTFZ4SzZsYjRtb1FkL3gvb0VJdHZpRlM3?=
 =?utf-8?B?T1JwRHdMOTRwaldZM3oyTmlHV3YxMU1NanVuUDh4VjZjbW1qMnhPQ3ErK1JH?=
 =?utf-8?B?TWIwWHBPb0xpZ3E4U21BblVtNlZXWkFWSlJzSEc3N243UE04TnJCZElqWGtC?=
 =?utf-8?B?bHRvRFVuWXR3Y3pqTzJ6aE8zYURJUEd4S1JOdjJBcmJKTmduRDI3N3N3Q1VD?=
 =?utf-8?B?T2RlNXljWDIxRWJieCs1aU95ekhuSklMeGdybHlNUExabjFqaXlYcVgwT05z?=
 =?utf-8?B?TXY0K1ZMdFhPZ3JJeW1SSW1RakxnSHAwZ1E2NmdBejNLVXZFRFQwa2tVMDVH?=
 =?utf-8?B?WlRWTDFCaHlWS042LzRkK0VHRExDUmFURDlLKzAxdU83R2N2NmNySE16ZXUy?=
 =?utf-8?B?ZVc5Z3VwNVVXZmZQdFRNNTZibEl3ZTU0RUJjV3E0MVlBRlgrdDBVSzIyYXNM?=
 =?utf-8?B?NVY5NTcrYi8rVzlvekRBck9YcnJwcGU2a0ZoTFNXZFpZMHBoQWNydUJFWXl1?=
 =?utf-8?B?dFFUbStGb05aQjBtYTFaS0toMVdJM3pwOHViTU13SmtGbGZFbCs4bjV5emhr?=
 =?utf-8?B?YzArTTRLcDZVSDBRamZZVFp3cU9BN2l0Q3c2aEFDT3VoUzMrM3cxVU1odEFu?=
 =?utf-8?B?RGw1QWtyTmprWUxYYkFzWEk5VERyejdTWHp4cGpvdE5vQXk1blYyVk1GbFk0?=
 =?utf-8?B?NXMxRG5DYllhOStESGlRclFCMDF0TEF4czZCV1ZSSkxnRmRzNVEvdW5HQXpD?=
 =?utf-8?B?cGpRbkZGdk9yRkZWckFRSEVTLzlDcEM3ejJ2OEU4aWdCUDBxcllIWFdXNVFp?=
 =?utf-8?B?N0xZdTRSUzhkbWtBb3UybFRpemJWWHhyQkFWdmF2U3V2cnYyM2ZmU3hxalVP?=
 =?utf-8?B?cmhXY0pBS1p6OWdSY1ZiVDh5RXdxUkg4WmpIaTVocGRjVzUzRUJSTitkNFp5?=
 =?utf-8?B?dlZwdkJONE9tcnY1RXphNHFTazQ0Mi95Z2hnUVo0VVhvY2FpTHhhMU1IRkkz?=
 =?utf-8?B?S3RCbXZqUVp6SXl0S3p2U05taDZlTWoxck9WL1FGNk1QT3BRWDY4ajh5Smtm?=
 =?utf-8?B?c2I0UXlGTEtnWGVuNlUxN2lETDBicy9saVJDT1ArSkFNVEVIODRFUDArT0pK?=
 =?utf-8?B?TkZEeVh6TVVPOFJndTM5a2pSWTc4NW9BdEtUby9HNXF6K0NDdGJSZGlsbklS?=
 =?utf-8?B?SUhxbGxuYkdzclVHT2VORGpaNFFydnU0aEZvTHlRd2RZLy93Q0JtWGNPZEVH?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C70D4BF88C3D394FB53F5C7C31F248D3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SzVvUzVrZnJ0bmFrMkUvbWxkcVRoUjgvUWN3VWxaUnhRR2hFNGtCWHRzR2FG?=
 =?utf-8?B?dHV1OVJmNmhTb1ZMazRsSzFoTkFDbjhQQ1VFekRVcGZLK1VVb3c5Yi81MmQy?=
 =?utf-8?B?d1g4cUdOZ0Q2SlhNTG5QaFhlMlFIeVBrN2p1NkRScnJBU1JaWDZNV1dRRWcz?=
 =?utf-8?B?ZlJ6WWZjRWMrZVV6dm9TSllWdkhIamZBSkt2UTZPQ3gzaEs2UTg1bkVidTVH?=
 =?utf-8?B?bVhKRDZwSlNQQVVaOGxLb0FYaHc4enNjMEhPa2xoelRrcUpoYlBSODdLbzRF?=
 =?utf-8?B?ZXpOM0VpVU9KUmVGdGQwTFhQdndMN2E0SytrUVRFSGh6bFVlazl1d1FUTnZ6?=
 =?utf-8?B?SFBkb1FHcE55K0VOSkFhdEFqOTNsSnJDeGtWZmNtQkFuNmJLZlMwNmRIaGFy?=
 =?utf-8?B?c1M4ZmNHM281UnJQSlJRMzhEMG9VSXpDMHYrZ0Nidnk0OHBQOTVIQVFvdWZE?=
 =?utf-8?B?YStuM3piNk1QS2pMRGQ3Nm05aldEZ2hUSTJMQmM0ZklFUjJaM3BGSUJJT0lN?=
 =?utf-8?B?TUdFQUNQc040U2pDMkwrTFc3b2YxMHEyZm5VZlFyQ3Vib2RkK3NWS3hmZ0Vz?=
 =?utf-8?B?VzZER3lBUUFqSTRTQmlhdW12VE12UEEzQ09SZEJxbUhPQ1Uwbm1saTRXNjR4?=
 =?utf-8?B?ZlZwc0U3ck5uWkQwTldLN200eFZKNkRNQnBjTE5uOG5qZ2RPTjRJZ21sN0hW?=
 =?utf-8?B?UDkrbGtRRWFrWEIya0p4TWdibDNBTmx0Q0U2QmswN3VnT3k2dTFlU2paVi9T?=
 =?utf-8?B?Y1JjS0tvTk9RMjhxODAxeVBDeENNclF0Z2NtWXFZVTI1SHhzODkzWkQ3UzBS?=
 =?utf-8?B?ckZrZUNSMEkwclVEMGpNZXVLbFZVaTlScHpiQmFYYUFlUVI4TUYwQitScFhC?=
 =?utf-8?B?TVdoRXpTVHpFcjFpQ0FHelhaZW1nYlh1SVpaalZGc3JMN1dHem1BVXMwNlU3?=
 =?utf-8?B?TDlXQkNWdWFtMmxZQS90LzJJendyQytRdEg0a0Z1MVI3b3BjUXlJa2ZOa2k5?=
 =?utf-8?B?QUYyT0pZbHMzVkZPZjltTjRLREVCYlRVcmZNcWx0UDNrOUVEUDBVcDFBYWRn?=
 =?utf-8?B?K3NlWmpscXltU3ovS25ENjQrckV0dHNidUVpa3RFQ1g2aTkycWVhTXpXS3Za?=
 =?utf-8?B?UGh0c0xZbHhDUmhoUkg1bHFNZ1lTdzRZSHVWYWViT3ZUWmU0eVZqYzBsOC8y?=
 =?utf-8?B?cjJaZGJmalRyT0JENmtvY0N2b1Fnck5nLzBxNTlybm9HeWFENncrZXA5Q2N6?=
 =?utf-8?Q?0yed40zL+h/wZTv?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8733f10a-f99f-4a51-7184-08dac77bc0a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 02:39:15.2366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlnrliCvmKGF4ZncC1gupTR70Haovr3JM9NiX0df0+p4D0HESJM4WC2vfEVUJ4550k9wgKhhqvqzPlvbfclQkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9379
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE2LzExLzIwMjIgMDg6MTAsIFlhbmp1biBaaHUgd3JvdGU6DQo+Pg0KPj4gaW5kZXgg
ZDRmMTBjMmQxYWE3Li43Yzk5ZDE1OTE1ODAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9tci5jDQo+PiBAQCAtOTksNiArOTksNyBAQCBzdGF0aWMgaW50IHJ4ZV9tcl9hbGxvYyhz
dHJ1Y3QgcnhlX21yICptciwgaW50IG51bV9idWYpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAga2Zy
ZWUobXItPm1hcFtpXSk7DQo+PiDCoMKgwqDCoMKgIGtmcmVlKG1yLT5tYXApOw0KPj4gK8KgwqDC
oCBtci0+bWFwID0gTlVMTDsNCj4+IMKgIGVycjE6DQo+PiDCoMKgwqDCoMKgIHJldHVybiAtRU5P
TUVNOw0KPj4gwqAgfQ0KPj4gQEAgLTEyMiw3ICsxMjMsNiBAQCBpbnQgcnhlX21yX2luaXRfdXNl
cihzdHJ1Y3QgcnhlX2RldiAqcnhlLCB1NjQgDQo+PiBzdGFydCwgdTY0IGxlbmd0aCwgdTY0IGlv
dmEsDQo+PiDCoMKgwqDCoMKgIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX2J1ZjsNCj4+
IMKgwqDCoMKgwqAgdm9pZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnZhZGRyOw0KPj4gwqDCoMKg
wqDCoCBpbnQgZXJyOw0KPj4gLcKgwqDCoCBpbnQgaTsNCj4+IMKgwqDCoMKgwqAgdW1lbSA9IGli
X3VtZW1fZ2V0KCZyeGUtPmliX2Rldiwgc3RhcnQsIGxlbmd0aCwgYWNjZXNzKTsNCj4+IMKgwqDC
oMKgwqAgaWYgKElTX0VSUih1bWVtKSkgew0KPj4gQEAgLTE2Myw5ICsxNjMsOCBAQCBpbnQgcnhl
X21yX2luaXRfdXNlcihzdHJ1Y3QgcnhlX2RldiAqcnhlLCB1NjQgDQo+PiBzdGFydCwgdTY0IGxl
bmd0aCwgdTY0IGlvdmEsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBy
X3dhcm4oIiVzOiBVbmFibGUgdG8gZ2V0IHZpcnR1YWwgYWRkcmVzc1xuIiwNCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZnVuY19fKTsNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0gLUVOT01FTTsNCj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfY2xlYW51cF9tYXA7DQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX3JlbGVhc2VfdW1lbTsNCj4g
DQo+IFRoaXMgY2FsbCB0cmFjZSByZXN1bHRzIGZyb20gcGFnZV9hZGRyZXNzJ3MgcmV0dXJuaW5n
IE5VTEwsIHRoZW4gZ290byANCj4gZXJyX2NsZWFudXBfbWFwIHdoZXJlIG1yLT5tYXBbaV0gYW5k
IG1yLT5tYXAgYXJlIGZyZWVkLg0KPiANCj4gQW5kIGZpbmFsbHkgcnhlX3JlZ191c2VyX21yIGdl
dHMgYW4gZXJyb3IgZnJvbSByeGVfbXJfaW5pdF91c2VyLCB0aGUgDQo+IGZ1bmN0aW9uIHJ4ZV9t
cl9jbGVhbnVwIGlzIGNhbGxlZCB0byBoYW5kbGUgbXIgdG8gZnJlZSBtci0+bWFwW2ldIGFuZCAN
Cj4gbXItPm1hcCBhZ2Fpbi4NCj4gDQo+IFNvIG1yLT5tYXBbaV0gYW5kIG1yLT5tYXAgYXJlIGRv
dWJsZSBmcmVlZC4NCj4gDQo+IEFzIHN1Y2gsIHRoaXMgY29tbWl0IGlzIHJlYXNvbmFibGUuDQo+
IA0KPiBCdXQgd2h5IHBhZ2VfYWRkcmVzcyB3aWxsIHJldHVybiBOVUxMPw0KDQpFTk9NRU0/IGJ1
dCBJIGRvbid0IHRoaW5rIHdlIG5lZWQgdGFraW5nIHRvbyBtdWNoIGNhcmUgdXBvbiB0aGUgcmVh
c29uLg0KDQp0aGlzIHBhdGNoIGlzIG1vc3QgbGlrZWx5IHBvcnRpbmcgdGhlIHJldmVydGVkIGJh
Y2ssIGNvbW1pdDogDQo4ZmY1ZjVkOWQ4Y2YgKCJSRE1BL3J4ZTogUHJldmVudCBkb3VibGUgZnJl
ZWluZyByeGVfbWFwX3NldCgpIikNCg0KQWN0dWFsbHksIHRoZSBkb3VibGUgZnJlZSBjYW4gYmUg
dHJpZ2dlcmVkIGJ5IGJlbG93IGVycm9yIHBhdGggdG9vLg0KDQoxNDkgICAgICAgICBlcnIgPSBy
eGVfbXJfYWxsb2MobXIsIG51bV9idWYpOyANCg0KMTUwICAgICAgICAgaWYgKGVycikgeyANCg0K
MTUxICAgICAgICAgICAgICAgICBwcl93YXJuKCIlczogVW5hYmxlIHRvIGFsbG9jYXRlIG1lbW9y
eSBmb3IgbWFwXG4iLCANCg0KMTUyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19m
dW5jX18pOyANCg0KMTUzICAgICAgICAgICAgICAgICBnb3RvIGVycl9yZWxlYXNlX3VtZW07IA0K
DQoxNTQgICAgICAgICB9DQoNCndoZXJlIHJ4ZV9tcl9hbGxvYygpIGZyZWVkIHRoZSBtZW1vcnkg
YnV0IGRvbid0IHNldCAnbXItPm1hcCA9IE5VTEwnDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCj4g
DQo+IFpodSBZYW5qdW4NCj4g
