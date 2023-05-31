Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D75F7189C8
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 21:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjEaTE6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEaTE5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 15:04:57 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9531F101
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 12:04:56 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-626149fbc8eso889626d6.3
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685559895; x=1688151895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=55EZdRKawvywEhrbC7BpBXsx5HuuUYXOihAkNZH/MO0=;
        b=pWsxzsmg771TOdEFNtaXdyB2oUh3rVCYyTNw/hfZarQt3YcGoQzykrhCiMD74jqicY
         KX+3j6oTwdq0nnx2QwhUZfhD1vZjumcyv5tJSYOe1TY3jl7LhE/7p7JxrAGlcu7O4BNn
         +1ueT2nygtj5SUFjn1n9J8LIt/9eUSF1jlNps0VyYJfsGggVDpcMzzpE4GgSFD+VuIi/
         GbOZ63V+Sq0JqaLPpaKLELJZUc8mEU5wW692fyWlIteDgwGuiSaBoI8RArc5xUAeIa7r
         5dJYY9ALmSK++p1qTWShWK8+5tNgtUysfNch8cYJP9RjU0CmEk6gDTQdjpKoFUwq371z
         w7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685559895; x=1688151895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55EZdRKawvywEhrbC7BpBXsx5HuuUYXOihAkNZH/MO0=;
        b=JPPwvctAfVqTgWWhli6jNHZ7H6dKTw+rHaEezrcZdYoZne8QYe1L19hiG9dxsLxFSm
         wX9QojQw0chHggbiJR+pL29EaSz66BX/LJca6VuaSfCwNauqcqpr+1TyGzXN0r/0zkYE
         lvcgnI2DeR+Ow+STCvOIdCgWukVytedm4eUp2M/EmLxxXSXXujEzoPR70X+zWvVQHspE
         vV7zlZuyjVZyLdJ83ehMUco0/5/NPqju5Nca03UkoTEjeGO9cWoOom+JW14tFvX2Roxs
         MDHYJ/uINx18UoQoYBcEZIeEBzMEo42Ej3LogViutNYckqnn5G4aORjGNLNmncmamXVR
         sU6w==
X-Gm-Message-State: AC+VfDwg36FGuEr6Yu4jHtMV+/GctPqSKJBZpLDop0Phiqpzv9whwLV2
        wfkefhyi2z8kwkZsiApthMbwdQ4zSMTqWZdCMoI=
X-Google-Smtp-Source: ACHHUZ4yata1LcfSPtHo41ono6PwRoZmU222yNfJWyoG1NlvYfLT2L3YHWy3WFq2BVDg9BMUObGLMA==
X-Received: by 2002:ad4:5b8f:0:b0:621:2ad5:df74 with SMTP id 15-20020ad45b8f000000b006212ad5df74mr7776699qvp.51.1685559895712;
        Wed, 31 May 2023 12:04:55 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id v17-20020a0cf911000000b0062618962ec0sm4280792qvn.133.2023.05.31.12.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 12:04:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q4R7t-0017TK-Kw;
        Wed, 31 May 2023 16:04:53 -0300
Date:   Wed, 31 May 2023 16:04:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>, Netdev <netdev@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH RFC 3/3] RDMA/siw: Require non-zero 6-byte MACs for soft
 iWARP
Message-ID: <ZHeaVdsMUz8gDjEU@ziepe.ca>
References: <168330051600.5953.11366152375575299483.stgit@oracle-102.nfsv4bat.org>
 <168330138101.5953.12575990094340826016.stgit@oracle-102.nfsv4bat.org>
 <ZFVf+wzF6Px8nlVR@ziepe.ca>
 <7825F977-3F62-4AFC-92F2-233C5EAE01D3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7825F977-3F62-4AFC-92F2-233C5EAE01D3@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 23, 2023 at 07:18:18PM +0000, Chuck Lever III wrote:

> The core address resolution code wants to find an L2 address
> for the egress device. The underlying ib_device, where a made-up
> GID might be stored, is not involved with address resolution
> AFAICT.

Where are you hitting this?

Jason
