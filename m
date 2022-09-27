Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DA75EC42D
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiI0NUS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 09:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiI0NSo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 09:18:44 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B4418D0D2
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 06:17:26 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id d17so5934230qko.13
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=s0NNEqO6LLVb5YMIpc2TyrWpFZzqap1mkNjCl7Lo6vc=;
        b=d1p1D7imuN7X5usrYudjDh0sTI10G93m9x0FY8tNRFBdkKNy/+Dt/5BnKnlTMcKQ47
         u6GjRjTm5QOlLQP/qmmZZYg1Cn4RJbW8TPhWZ+t7o+Q7+XKVJbsA9INCuz/qB1K7J6yT
         /N6IK4LI3Pzc5JZF6OIQv9KEs5mGv1JShJAEOMoW52OqhDXUctcAEvKvdj+l4QYbX5LS
         neR8sy0WtlZZ8aIMKj4TMy6oKel8WCQ/GElw2CbGWCryuXgXpBzMhLPlambtR5QH+a3x
         1v8pO2b3hUp3PDCrMuGxEnrqP+eSmiEpeX8J0LHd7CLixDoGM0Ru9eZL7JQ6IXfROC26
         TQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=s0NNEqO6LLVb5YMIpc2TyrWpFZzqap1mkNjCl7Lo6vc=;
        b=7SRpEBzlnnuIPb/xMC8iqo3NpUeRz6Yq0gn8dW2GrAWzsMP9ADpcvVytLFAhBosxsw
         J5A2eNwogwSrUMSTLxACvJjfcClx68CSoRl5ozkcXrgUZ8xnQYNIH7j+AtsxLT3xhJop
         z5t3DZYoi44k8Y+2jcyPgyolqidTWbWeqP3mMIgoTXqfTfWx2uw6nI3e96rxPU3EGdC8
         ffSZwLNbq8gg75rjhi7bSn6PgklSNe8sMZbobae9zvdwNaMoA3u6ryzYGHTSHAQO7uAw
         A+l7IZZx9j6IPzF4OV0IxZ+F/q+C4djtOgimxtgMPd8+9ptNJ/ZloYuHNCDHCyIhoqTk
         q1EA==
X-Gm-Message-State: ACrzQf2wluzi/K5y4+t/tCHCODv7dzM5192ShqC+DPBiTjPoeVPZMM6Y
        Fnsa3A3V+2TBdaZtBSO+Mh0KNw==
X-Google-Smtp-Source: AMsMyM7eZ+63NxBLkanzTmdOKZNpEm9M11/gxzrEjfHu066nRJKGOetr/jq1B8L1GjN/4DGy1yYX/A==
X-Received: by 2002:a05:620a:d8c:b0:6a7:91a2:c827 with SMTP id q12-20020a05620a0d8c00b006a791a2c827mr17306858qkl.407.1664284622550;
        Tue, 27 Sep 2022 06:17:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id u35-20020a05622a19a300b0035bbb6268e2sm798728qtc.67.2022.09.27.06.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:17:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1odASK-000b6d-8G;
        Tue, 27 Sep 2022 10:17:00 -0300
Date:   Tue, 27 Sep 2022 10:17:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     =?utf-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [RESEND PATCH v5 1/2] RDMA/rxe: Support RDMA Atomic Write
 operation
Message-ID: <YzL3zOS3YxRvyYDF@ziepe.ca>
References: <20220708040228.6703-1-yangx.jy@fujitsu.com>
 <20220708040228.6703-2-yangx.jy@fujitsu.com>
 <fb02de6c-a32b-654a-62b9-55f44ffaec30@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb02de6c-a32b-654a-62b9-55f44ffaec30@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 27, 2022 at 04:18:52PM +0800, Li Zhijian wrote:
> Hi Yang
> 
> I wonder if you need to do something if a user register MR with
> ATOMIC_WRITE to non-rxe device, something like in my flush:

This makes sense..

Jason
