Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422566F08A4
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Apr 2023 17:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbjD0Pr3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Apr 2023 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244179AbjD0Pr1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Apr 2023 11:47:27 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE93C422D;
        Thu, 27 Apr 2023 08:47:18 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-38e12d973bfso4759015b6e.0;
        Thu, 27 Apr 2023 08:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682610438; x=1685202438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c31z0HuMy1qMUEK/A5IDTwlwqb2ZEBzE09RqDF8xAlc=;
        b=bRuYOu2yWNuTdErOP8Kfzt9oVwcrL9gCwA2b7a33nxY3E599a2ow7kK3XPoVwG3xMJ
         S0z1uki1ceLS/75TZf5zUh+S7F3sNfyKovrXScSTbBd8B9KtDoejA2e+/zj6whN0ZYNW
         FkHKi+xDOoAONu9fZlM8T87/tBkjr7OkN8/qhQHy+ILTaedtXqQMafzqqcNcCFZq0C03
         KDzraktJbNJjVYJUJ5x0XATibonKeXctqLCO54XrGWHv1fsjqMQjAjVXSd7nBgKr5U2i
         TiGguurBk09La4pXF9ds4pDmbzo8dk7Lzmrxhr5lfVThrJbF8S0MBLcm1Hd4m0z91WvL
         fYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682610438; x=1685202438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c31z0HuMy1qMUEK/A5IDTwlwqb2ZEBzE09RqDF8xAlc=;
        b=TGssjo6qgMkvTy+DDfE4zmCfIzjfHKKqktH9kP4x7kl3YYQKmo7uO1HSpX2hjE4p8V
         AyHDSIPnG48X2WDP/H/90XAI99JUzAhrs5TKIFcywC+SR/KCl2QxLjquz0OwRkFCf7tV
         aTs2d/9TbeWb4v/d6Z59Dtam5JgrH4xYL009yUiiDIRc7FrNpKghXO8wCmU/a+nWkICl
         u1ixgS1PQnGOPoDCdafNKxi4QDQHyN3ySxTUWU0K3AOJ88RcjA21sNmiHYlq3PtbL6ED
         cxFHpsLMzF2xtqIU+KaaIVAU/79TF9YxOcjUUCdpkMjd1kgKq6PAquYYHLyxbu8oULdi
         KTQw==
X-Gm-Message-State: AC+VfDz1qDk0EtY9mQaI1gufJaB2KWd31EtHuQzh7hcbBNYbT2B3EU6a
        ypo0b+msU40tS2av8ZMModo=
X-Google-Smtp-Source: ACHHUZ7N7yM+tN+1iVlFpfDpDsnPokejJx+8yl8WQxMRbJ/xj8XAd5vQGDf+bG5kZHz101V5knVKyQ==
X-Received: by 2002:a05:6808:d8:b0:38e:8e21:d044 with SMTP id t24-20020a05680800d800b0038e8e21d044mr874831oic.6.1682610438124;
        Thu, 27 Apr 2023 08:47:18 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:d311:e3b9:f687:8c9f? (2603-8081-140c-1a00-d311-e3b9-f687-8c9f.res6.spectrum.com. [2603:8081:140c:1a00:d311:e3b9:f687:8c9f])
        by smtp.gmail.com with ESMTPSA id m5-20020a4aab85000000b0053853156b5csm8445014oon.8.2023.04.27.08.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 08:47:17 -0700 (PDT)
Message-ID: <58461c53-ad21-744a-d67a-3a1b9fbc5ae8@gmail.com>
Date:   Thu, 27 Apr 2023 10:47:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH for-next v4 0/8] On-Demand Paging on SoftRoCE
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "'Pearson, Robert B'" <robert.pearson2@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
References: <cover.1681882651.git.matsuda-daisuke@fujitsu.com>
 <MW4PR84MB23075F0B2E684D7EDE8AD6CCBC629@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <TYCPR01MB84559CC9CB14DC577AD08E60E5639@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <TYCPR01MB84559CC9CB14DC577AD08E60E5639@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/19/23 19:28, Daisuke Matsuda (Fujitsu) wrote:
> On Thu, April 20, 2023 1:07 AM Pearson, Robert B wrote:
>>
>> The work queue patch has been submitted and is waiting for some action. -- Bob
> 
> Hi,
> Could you tell me which is it? I am willing to review it.
> 
> This seems to be your latest work queue patch:
> https://lore.kernel.org/all/TYCPR01MB8455A2D0B3303FD90B3BB6F1E58B9@TYCPR01MB8455.jpnprd01.prod.outlook.com/
> I cannot find any one newer on the mailing list nor on the Patchwork.
> 
> Daisuke

Daisuke,

Sorry for the delay. I've been on another project for a few days.
I can't either. After the fix qp counting in task.c the work queue patch is almost trivial.
I'll send it again.

Bob
