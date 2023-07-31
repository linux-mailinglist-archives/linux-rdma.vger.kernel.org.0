Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0F776A05E
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjGaS03 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGaS01 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:26:27 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2F71725
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:26:25 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1ba5cda3530so3654137fac.3
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690827985; x=1691432785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZapsdQSgLleeR5eqAC9r9gBoROkXI8ut9M3xUyj7Lss=;
        b=Vud4QmJpvcRJ6d394j+bC1O4EfgSeqbUV6v7veR8E70m6IQWN4FLKn6xzH1cEGxujs
         88zUOjqkv8/9W5PZRVbqbKBnT1ic1eAdWq7V/giulSx9SZaCDOEiRi/Tjw3S3KqvBFHA
         T9IROeidrBYcwyRnqM9B0I9xEIS9ZFYkSvlStEbgqPLt0wQlKqKnwiEvoRlkKWSXUCfh
         h9RPhfyd8yiLT160Glyqn4YSewssyoBXM2QwJXxzBGzJDzdt4wxd0KmIqXxRx+ESPjA+
         PFNfeJSKuoMSW7R7PfA1OHrOQKYA6lBT5OD1R07Fhz8/yVldXW2SX9G0sIvAKIHihNcc
         k9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690827985; x=1691432785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZapsdQSgLleeR5eqAC9r9gBoROkXI8ut9M3xUyj7Lss=;
        b=BEemYJN/YboX3ldFy21Lw9BIGReThujq8LdN0yR9AKykTk/xRvZF+zQklRRTZ76Qb7
         aOPSKZDidwqU6rbfsYmnhGUA+TkIGnl7aMpo020iSvTo3GOlPAwe14JYG9MYr8liSDwQ
         bZ3K1ZrMZv7cHCXKH5rkTXPsr2mz8DNzoJSNXSduDk6WXGAa2uo2CDnf5gMUWE1KlT5s
         gkC0NOphOSuz55IEytbBDOabfOKTxgEIG7ZtYLSXJfBBuEjzjbHQk3uwI5npZlg2nbqo
         5N0o4qToddmRkINbKl/C2Tp7kqnRSlXvL+tduXy8HbnG6v7/CHWY81m60mBQqPzm1mCh
         Mk8w==
X-Gm-Message-State: ABy/qLa0Ci53/d95UqNm+y/vHf6cRnqETRt64Ipuw/m5UyaVgDyZltdR
        3EMc1k9vAyT0D1cGltZ69u8=
X-Google-Smtp-Source: APBJJlF0rJwHquOy4B0X6LRyvDsXYibiD2FdI2CqU+F8W/F4L/ynLwuYEo0ysQKcNp8xcfFpJWTTqw==
X-Received: by 2002:a05:6870:a710:b0:1bb:a736:cb6d with SMTP id g16-20020a056870a71000b001bba736cb6dmr12033396oam.13.1690827985175;
        Mon, 31 Jul 2023 11:26:25 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8206:c67a:f41a:8567? (2603-8081-140c-1a00-8206-c67a-f41a-8567.res6.spectrum.com. [2603:8081:140c:1a00:8206:c67a:f41a:8567])
        by smtp.gmail.com with ESMTPSA id a3-20020a4aae43000000b005630547db40sm4092286oon.41.2023.07.31.11.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 11:26:24 -0700 (PDT)
Message-ID: <1ee51a2d-3015-3204-33e3-cfcfaac0d80e@gmail.com>
Date:   Mon, 31 Jul 2023 13:26:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-next 9/9] RDMA/rxe: Protect pending send packets
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-10-rpearsonhpe@gmail.com> <ZMf6xkpicBpXr/B9@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZMf6xkpicBpXr/B9@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/31/23 13:17, Jason Gunthorpe wrote:
> On Fri, Jul 21, 2023 at 03:50:22PM -0500, Bob Pearson wrote:
>> Network interruptions may cause long delays in the processing of
>> send packets during which time the rxe driver may be unloaded.
>> This will cause seg faults when the packet is ultimately freed as
>> it calls the destructor function in the rxe driver. This has been
>> observed in cable pull fail over fail back testing.
> 
> No, module reference counts are only for code that is touching
> function pointers.

this is exactly the case here. it is the skb destructor function that
is carried by the skb.

> 
> If your driver is becoming removed and that messes it up then you need
> to prevent the driver from unloading by adding something to the remove
> function (dellink, I guess in this case)
> 
> Jason

