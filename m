Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF25729F83
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbjFIQBI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 12:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242019AbjFIQBF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 12:01:05 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6F3359D
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 09:00:59 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75eba89e373so188615385a.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jun 2023 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686326458; x=1688918458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fsGZS3k18OIHcB/OEhZYsAWa2UlqaDu7rnYDiQMSlRM=;
        b=GJ3GbIfia6KAPOBhrm5Ra8vmkVciwhP1NnOlO2puY5G5lSAlQfNBKmkOpM7BPdbxdZ
         1GAOEP51WIYBegIThTmiaslaPgBp0rMwerNLUhLnK6/q5F9f/THvfu0RxInxjTvr3PK4
         Hhw+dt25+P5HV7udNDPs3DpnBqZSf4wxlX4Cp7G/Nq9yQwdXjh/l0JDI/Wg93ZGaADjQ
         GVlT2q0ZY5LvPPKvElKYG8W/H03pW/+Fxzryfj1LYsRtSlGtwXunI7ahH0utPZBmBVv9
         Ko8Yr2/PL9ohSu72LfjWpnKv/9SdU+cb0ltXlYWS8A6WqNoOnEf9ZVGdV+7THcl3s0Sf
         ld0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326458; x=1688918458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsGZS3k18OIHcB/OEhZYsAWa2UlqaDu7rnYDiQMSlRM=;
        b=SFQWk1QQJPzIfT2u+US8fsZlz+WjTF7DU0TLvGOGB370paeoXOA1fS8a6YJYEYLZ9z
         2SuRVLJg+YEm4bb9aNr04a6jxffj3MQ1GnnWqVFJfa0dgGWF56ZWPS1S6hWFVPVYQXmC
         c3e6rR2P04TFCx8kT3/PjskAcfLm5bdI8sIweNDxPGrZVDN5qIBg29z716tywf/Mo99r
         05UkXtjGsklk2Z899fi5355Dzt8vAWW/T4ssCKo0kCHejOSHRgZNwpecI+Q+59lABgLU
         urz6PLuprzge9rwiNiR2FLDPke1uqsBZt3Rb15KQqpAi9bs+ycBmgo6clatFpa6Md/ah
         IbOg==
X-Gm-Message-State: AC+VfDw28WV4PhSXwwXPIZKF0dCmWL1Pxk1rYemtrg1g9liMm7/oMiFe
        jXTCp8ZtP7ptaqs7tzTULHHYFw==
X-Google-Smtp-Source: ACHHUZ4o2J+kocRMm6Wz4FthNUSp+wtkeGVDQh+g2BnGITpguVYpzTWgkMZPeAz/s9FmakOMaJzknA==
X-Received: by 2002:a05:620a:808e:b0:75e:c6cb:c144 with SMTP id ef14-20020a05620a808e00b0075ec6cbc144mr6981417qkb.15.1686326458604;
        Fri, 09 Jun 2023 09:00:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id hr6-20020a05621423c600b006263735a9adsm1219348qvb.112.2023.06.09.09.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:00:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q7eXp-003wOD-4b;
        Fri, 09 Jun 2023 13:00:57 -0300
Date:   Fri, 9 Jun 2023 13:00:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vacek <neelx@redhat.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Rogerio Moraes <rogerio@cadence.com>
Subject: Re: [PATCH] verbs: fix compilation warning with C++20
Message-ID: <ZINMuV+XhTCnnlK+@ziepe.ca>
References: <20230609153147.667674-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609153147.667674-1-neelx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 09, 2023 at 05:31:47PM +0200, Daniel Vacek wrote:
> Our customer reported the below warning whe using Clang v16.0.4 and C++20,
> on a code that includes the header "/usr/include/infiniband/verbs.h":
> 
> error: bitwise operation between different enumeration types ('ibv_access_flags' and
> 'ib_uverbs_access_flags') is deprecated [-Werror,-Wdeprecated-enum-enum-conversion]
>                 mem->mr = ibv_reg_mr(dev->pd, (void*)start, len, IBV_ACCESS_LOCAL_WRITE);
>                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/include/infiniband/verbs.h:2514:19: note: expanded from macro 'ibv_reg_mr'
>                              ((access) & IBV_ACCESS_OPTIONAL_RANGE) == 0))
>                               ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> 
> According to the article "Clang 11 warning: Bitwise operation between different
> enumeration types is deprecated":
> 
> C++20's P1120R0 deprecated bitwise operations between different enums. Such code is
> likely to become ill-formed in C++23. Clang 11 warns about such cases. It should be fixed.

There should be a cast to an integer in the macro, we can't know what
the user will pass in there and it may not be that enum.

Jason
