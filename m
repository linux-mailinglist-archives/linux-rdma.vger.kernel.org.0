Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5254F611FAC
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJ2DPO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ2DPL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:15:11 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D497C1C110
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:14:56 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r76so1528067oie.13
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrT9wE2gDryaLfsINwjDZA7j4FIsyZCe6fSR+sC2HXg=;
        b=Z7EhRUewjIvODC4dhRj3JuRGpOnfGxcyYDUDdlRrEQ1l/YhOKu1wMKWM4Ze+aKkDLo
         2OargvZsp84q12b11fgFH1KZsdcopsVKtwHfPlTOLXKyK/KVQd1jOStG2wIFZ90ZfRcK
         swL5dUrOolWYgLH87FStGFOzWchNauZswVFKr42U/k+AJAJpcGlm/7JijKO2uKLX9Eeq
         Lj3qMu8YonjgHp+tshJYVfJpBeu+h0lSmDRjlv/ACptnuw7kKejEamQpBJP9YVTr2wcx
         mR6SA3kJoyjBK2BMBah94uAIqMbincogM8v34niOy1EX9kCDXE0uGSzm3br0WW8dmtzG
         aheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xrT9wE2gDryaLfsINwjDZA7j4FIsyZCe6fSR+sC2HXg=;
        b=pJBE6sfMn6u6bnPAW3VAxd0LeE+WlaDqf1i73JPBCybzoY1o5ocvfe/Q5OSDSUQJOV
         sP0rmfLUh+EvDhakg+s6kgVy3IdqVXDzmVEn3Lkc6jA5b6IyrgyuL+0tt4S0i/hojjbb
         Avp29ldbiHU2nZvgvmc5ig2/c/p1sCbic4CgSMStIdnBOehKOaiMa77C9wbATco65eQD
         ST0lcSF9i3u73ZcXG0G3zk291SlbjZy2z/oOaqKg3zEoRr2ozv4uwK6714wnV7GRtnB2
         wQFn6joUyV0g6NzC2gPQyKxJFlournZ2023UOFtRKYyw7aRS2SO4AN5li1A5hw3cp6yA
         47DA==
X-Gm-Message-State: ACrzQf3iAT445UjFps3NJVMLMgk5wT0sLgI1/1bK6NBItWbuqBcw0aRQ
        5yAdjtxBhmtqS8ecas5j6tw=
X-Google-Smtp-Source: AMsMyM7SZ4YGdj8BDU7STgOZGcFjgwkZ/zo0FJCRn4zIPw0sN6ugBVesJta3pUeHDDsawtJL7b9juA==
X-Received: by 2002:aca:1106:0:b0:355:1196:8f73 with SMTP id 6-20020aca1106000000b0035511968f73mr1307544oir.236.1667013296248;
        Fri, 28 Oct 2022 20:14:56 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:ff6f:6a:59a:5162? (2603-8081-140c-1a00-ff6f-006a-059a-5162.res6.spectrum.com. [2603:8081:140c:1a00:ff6f:6a:59a:5162])
        by smtp.gmail.com with ESMTPSA id p22-20020a4a8156000000b0049052c66126sm172382oog.2.2022.10.28.20.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 20:14:55 -0700 (PDT)
Message-ID: <8cca8a95-f269-a85a-9104-6a259aec52f7@gmail.com>
Date:   Fri, 28 Oct 2022 22:14:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: I resent 05/13 because it was missing the for-next
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I had put them in by hand and missed one.

Bob
