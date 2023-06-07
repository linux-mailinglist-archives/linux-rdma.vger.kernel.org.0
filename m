Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4416B7264F7
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jun 2023 17:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbjFGPqQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jun 2023 11:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjFGPqP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jun 2023 11:46:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665AD1988
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 08:46:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977d4a1cf0eso592698266b.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jun 2023 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1686152772; x=1688744772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qIw2A60B4BjBt1RP4tlsLtZqY4cMU7qp9v2JDYqqCto=;
        b=aobqQ6U9Zpq4LHvpXJvQ9XUToDPq9JiBtMkMIp2N/Lk3NlHM1tok7k7r50jnpC4+05
         AikIpMhUcNV5DThlk23Ho2oruyJT1M+vt7C7Ly1G9/adKvdKIt5DiAaVfFOgoFadSAqM
         IZbENBIrywmL0c62RkMyFRpGbQrTjCtmhjYCZBYlcVlnhjXIClTq1Z/EsVAEfLtp3pTX
         9MhOPg18QS4UX6/FlK5op41SSqwp+XudzMgGYjkO565o8ImThWm92MOA3xlFS+w7hLi+
         wGgLKKhqlb7JjuqCQ1pWO65EY+Z3638gCFa35J3G63BGC0sJflK5klDWOEAAks0XObvs
         N4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686152772; x=1688744772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIw2A60B4BjBt1RP4tlsLtZqY4cMU7qp9v2JDYqqCto=;
        b=D881RKSp60c8ShmfemaLc8EZYjZHoXbWVe0bpzc4dpvXLg8QlthMlt5wel8yiXQzsd
         4PuKv8C6e9ZrGxyfb3pPjCQCuZBrKAA9ukcz5R0YW9SJsHaGngUTq7DvDWWmsVAJ/QwP
         dfk7K2avzs4iiHqR/9p7d70AWd3HN0P9AqEU1ywRZqA0Cg3cPLlFGDN3TdtSEo6wi5sG
         xrkqzICcq5YtWCoaODar9HPdsXYHLI+MVM+eOi6dOUd608RvhiJnmvJJpVSWl5ICA5BI
         Rtw0EUoAc6AZV0SLEYkHRLymeS9UPynV0ZBITZ/aapGDoijIfZhUS+hBjpo6Rz5xSrX0
         3UtQ==
X-Gm-Message-State: AC+VfDzisznqL0v33JMdFBDV7QBIGA+sbqJHp0BfEwNatlqInbPawFlC
        lLRL3MBAVfwCKHvvFmih0c+Rhg==
X-Google-Smtp-Source: ACHHUZ4g6tW5iHA+QNpPU4ukI4ZrTJHFWDjP9J/4wzQRLnXt9+Pfe4DJPptOS4u0qezDWEU5hn4jRA==
X-Received: by 2002:a17:907:c1f:b0:96f:a39c:86d6 with SMTP id ga31-20020a1709070c1f00b0096fa39c86d6mr6474484ejc.8.1686152771715;
        Wed, 07 Jun 2023 08:46:11 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t5-20020a17090616c500b0096a6be0b66dsm6956188ejd.208.2023.06.07.08.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:46:10 -0700 (PDT)
Date:   Wed, 7 Jun 2023 17:46:09 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Saeed Mahameed <saeed@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next 13/15] net/mlx5: Skip inline mode check after
 mlx5_eswitch_enable_locked() failure
Message-ID: <ZICmQcFEJkDn71Xq@nanopsycho>
References: <20230606071219.483255-1-saeed@kernel.org>
 <20230606071219.483255-14-saeed@kernel.org>
 <20230606220117.0696be3e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606220117.0696be3e@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wed, Jun 07, 2023 at 07:01:17AM CEST, kuba@kernel.org wrote:
>On Tue,  6 Jun 2023 00:12:17 -0700 Saeed Mahameed wrote:
>> Fixes: bffaa916588e ("net/mlx5: E-Switch, Add control for inline mode")
>> Fixes: 8c98ee77d911 ("net/mlx5e: E-Switch, Add extack messages to devlink callbacks")
>
>The combination of net-next and Fixes is always odd.
>Why? 
>Either it's important enough to be a fix or its not important 
>and can go to net-next...
>

As Jason wrote, this is a fix, but not -net worthy. I believe that
"Fixes" tag should be there regardless of the target tree,
it makes things easier to follow.
