Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8400325275F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Aug 2020 08:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHZGhc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 02:37:32 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:7555
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbgHZGh3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Aug 2020 02:37:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZpAQNz/bsdShEuZgkX8j0mMsWhMb6TBuwWAMvK547WQ2ia/ndROCt/A4qAqUcmFNpq6J/nPyYgN0ZzIh1acc6ReX9PPOFSiYm5DAiJFE9vxsTjQ467EOVdjTv6Ug9IAHw3k8rv/k5PHNfLIRlwlq+gXDf/F0XfXX1fFRA0YetTtzAFmsIx3hll3kISPvPGuJcXASrwiKvTdHBsvpJc+xhOO+etxqaTg+O9f4kKLl7ukydPc+lFCxJz53/PWb4XjcvgKpEfo7cxNNHAtoal0Nu5YqAwLKqDl8BS4pan2AfnzRX9AgusqjZYNcXCSwDdA+4G6rxEw0aRRxrLMixIAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDdvfjpzKUxAnqZFiLFoTUJb+HiI2wMIEaWEbB2klC4=;
 b=OsCKDa9q9utg3TWPCdPd4edxjSEU+xrGyACr6ihmz6dYlJ+LdZkN48p8WY/6S+EFcuq+sAkQvE8L9iLqDV74o/CCUbnXbKFnRtfboyHk/cgkC2yQ+vX7ViotE9F2NKnT0Nz4u6ggjtTyLnTR1InNqLMKn0M6Ptx2wAql84cblY6PSRGLKj/FqusqRFHi9Ed7PlyNvfwXXN/R5mKer+7sVzsaPbTqrAfU5iZUhC9WDhnCsZ/a2DsOkv/btU+A3awGOxGWJogMbtctLLpV0H69+wPPCKaRS4M5iXdl/hG0Bb+Uk30WS8Keb99yXcrYZ7TJ8LOZfqGtgLsS/KUatv+qWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDdvfjpzKUxAnqZFiLFoTUJb+HiI2wMIEaWEbB2klC4=;
 b=TUsZdiNGickcT4rcXifZKSqYkm7Eksxb7skMXYqbVWYlB8L0jpwhVb/V8nnVVUD4g4ZfdqhEt/I5eYMiAXsVsdU31bPbqdbPpM8l0oMYlgWf63cM5iF3rq0pWTxrkxw1ynWiZbsclz/vAiW+kbw4FZX+4T9FFzBcN+CJQTN7uVM=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM5PR0502MB3090.eurprd05.prod.outlook.com (2603:10a6:203:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 06:37:26 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::accc:489a:3f36:1567]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::accc:489a:3f36:1567%7]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 06:37:26 +0000
Date:   Wed, 26 Aug 2020 09:37:22 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Gal Pressman <galpress@amazon.com>
Subject: Re: [PATCH] RDMA/core: Trigger a WARN_ON if the driver causes
 uobjects to become leaked
Message-ID: <20200826063722.GG1362631@unreal>
References: <0-v1-b1e0ed400ba9+f7-warn_destroy_ufile_hw_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-b1e0ed400ba9+f7-warn_destroy_ufile_hw_jgg@nvidia.com>
X-ClientProxiedBy: AM0PR02CA0017.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::30) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (213.57.247.131) by AM0PR02CA0017.eurprd02.prod.outlook.com (2603:10a6:208:3e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Wed, 26 Aug 2020 06:37:25 +0000
X-Originating-IP: [213.57.247.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11a6deba-539e-4513-c8dd-08d8498a7ee2
X-MS-TrafficTypeDiagnostic: AM5PR0502MB3090:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-Microsoft-Antispam-PRVS: <AM5PR0502MB309042C043B20AC02B063267B0540@AM5PR0502MB3090.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OR0gWnaepHEj7bHGSGCu1Nr/5E94DLqecCBGCAIz2aSt2OlOLH9vTNVK1ugIHYCGv0c3u1jaCHuL/bTzH88m3JWBNBL0GcGFuskevJPpk/weWzHzZhzpbe3W3QxeniW5zX0goYI1U4Klg1kbVcS6KXFsDOYay2OhXgqRLFeQm8oCuWT8V1qQBhu0kax74h647Y9EtL213RkT8JNTqxHUq5gsI2VQ6oGk0LhmCI93Y8tljrP3+wIVEhXVYWv/n+HbjQKwWK6x7sOZk/y6I0qa64s8C6aRyN9cd7YfHLr8PJjfeMz2xxbAotpzKpCJ77sbBCewiEIAE4O1Ao7jNARrUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(33656002)(1076003)(6916009)(478600001)(6666004)(8676002)(33716001)(6486002)(956004)(8936002)(83380400001)(2906002)(26005)(86362001)(52116002)(316002)(16526019)(5660300002)(4744005)(66946007)(66476007)(66556008)(4326008)(186003)(6496006)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eAXkVvmnd/qm6Fp15vM2fe1HFbAe8g+T8Wyf96Qp2F+d3YzYBe+ckxs7kTbq5I0QHz+83S891+eBKdnnXJrEth1zkp5nK/KOONKRouazEsIiqZx2YLwqbEUEOZ8h7SsaLog7NjwuL0WireNQITU151AQoCLy0mMzXmGAxspoIvirTe4xsC1HUOMyeXc68BT583zHTQEUkeoN0ijZN5VdEy1Lr9XzcLkGnC4BeKnTnejluWEclHhLh7q1OjL+MjUGWpiOojb+gspgULIWwkfLFMFcdLC7Ca8o3yL7pJR8B8PZmJBe9/msOSY1/F0NiEEsTwLYZfpy9soJl5S5IvUvSHhQj+MZpj2UDd3dq4bDn/a+6yid6MEzasekUmA9HfgD8kaYuRDCDGZDV5MrIuI7myEkXS16Yboy3NvJ6xSEsMgdyf4kGOc7v3A2FVbkFtiKaHo856lK3XHELRilbNT0K1o3RbuIjAJQI4iDdy/dJG9ll1zxHLlR4Ei1+6GEOyepB8Iw1i6UlQ8XiuoBmtv81mZ9zw+43xybITmvYSbb9ngtW5uCBRn1lg2kSUpoo9kiax9eDk7GFHKA7/hdSI22MW3yzQZnnLaJYJJSx6JvoCCSPPxzL85mhDBLQEBh/sTS7IlfHAcEobaPgZ1zIYHonA==
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a6deba-539e-4513-c8dd-08d8498a7ee2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6408.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 06:37:25.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNrTNMU7SmN4afyoiJpFQh5o7JNqIloSJWGbX01iFTVuPtlq7dtjDTdPRgDnCAsXEpJzPVtABwVadZFJ7S5cTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0502MB3090
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 01:35:38PM -0300, Jason Gunthorpe wrote:
> Drivers that fail destroy can cause uverbs to leak uobjects. Drivers are
> required to always eventually destroy their ubojects, so trigger a WARN_ON
> to detect this driver bug.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/rdma_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
