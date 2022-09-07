Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D45AFE1F
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 09:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiIGHwD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIGHvw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 03:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7642B9E6B6
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662537106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8KMdampSVOfSjQJ+eYUB/+euJ05288b13jRxouoL8v4=;
        b=IezB9TYvDSRE7d8eZ3U7LmS9k+++6Su6DYFT/ukOl65iDNDtBdlFUnSmEqGeCU2OSfoU3E
        XCwgT4FDBAG7M6wNdP8Dc8S6vojhoHhhmb43n2RiL5zSxwF8qMrIrWhM9t5yp9lTk10m7n
        jAkW/NjoHwuiehTqKUn8Yzjr8BdJfrk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-e2qPz3DjOeqFMURTbl3SbA-1; Wed, 07 Sep 2022 03:51:45 -0400
X-MC-Unique: e2qPz3DjOeqFMURTbl3SbA-1
Received: by mail-wm1-f70.google.com with SMTP id ay27-20020a05600c1e1b00b003a5bff0df8dso242814wmb.0
        for <linux-rdma@vger.kernel.org>; Wed, 07 Sep 2022 00:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8KMdampSVOfSjQJ+eYUB/+euJ05288b13jRxouoL8v4=;
        b=gwP/JAJ7A1SxVqqY9JpbYE41CTRJTqbHo3nIut+ZYLeDrmkelLEyr2Fcatl8zSK137
         kUrJi4yYsg/FOE9f0JOu66KLw6mc33iN6utS7i7bsEoIVOPaCxL/9czGOaUZ3a+D9/kL
         nAh371fZMimyEFphCwXWIvbXCgOUPgqq5k06Qtk6wrKpWJtquwzVubpFl5nq7uYPIyzK
         NLaHmkzvAxkBBxOzQaMNyTmdLFvDuBMWsvEdEEi6SQb4qKm9rPczWXfvdnR2mPoCLGsb
         ta5zgdv/Gqx9m3vkfifGIo+aCcThZ4SUMkv8DuTsjZYSZpS86LdhZsrkAuCTHqti21gV
         5LsA==
X-Gm-Message-State: ACgBeo3+bmG7eeHMSVpwMFno53MxttFkhFEwMcAfpc9ybmVuPwPL5jVr
        LGNxu1TIuyeKgYuRWqpDgwaXolplbjRe/iqc3Jwk9lEj1RAAUzCrL1TYauSKi15VyTVl+onKRwG
        ZvQja+7wrfEzO+rfJlol+uA==
X-Received: by 2002:a5d:6f19:0:b0:228:d8e8:3ac8 with SMTP id ay25-20020a5d6f19000000b00228d8e83ac8mr1149252wrb.101.1662537103858;
        Wed, 07 Sep 2022 00:51:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6ThqBf88YF8iut0HC9FOIofHwvY/fghW1g6YgYSZwxQVisX9JDtm6hidIgh47utu42naZpeA==
X-Received: by 2002:a5d:6f19:0:b0:228:d8e8:3ac8 with SMTP id ay25-20020a5d6f19000000b00228d8e83ac8mr1149243wrb.101.1662537103667;
        Wed, 07 Sep 2022 00:51:43 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it. [87.11.6.69])
        by smtp.gmail.com with ESMTPSA id d14-20020adff2ce000000b00228d6edade0sm6597943wrp.46.2022.09.07.00.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 00:51:43 -0700 (PDT)
Date:   Wed, 7 Sep 2022 09:51:38 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     vdasa@vmware.com
Cc:     vbhakta@vmware.com, namit@vmware.com, bryantan@vmware.com,
        zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        doshir@vmware.com, gregkh@linuxfoundation.org, davem@davemloft.net,
        pv-drivers@vmware.com, joe@perches.com, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 0/3] MAINTAINERS: Update entries for some VMware drivers
Message-ID: <20220907075138.ph3bbitnev72rei3@sgarzare-redhat>
References: <20220906172722.19862-1-vdasa@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220906172722.19862-1-vdasa@vmware.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 06, 2022 at 10:27:19AM -0700, vdasa@vmware.com wrote:
>From: Vishnu Dasa <vdasa@vmware.com>
>
>This series updates a few existing maintainer entries for VMware
>supported drivers and adds a new entry for vsock vmci transport
>driver.
>

Since you are updating MAINTAINERS, what about adding 
"include/linux/vmw_vmci*" under "VMWARE VMCI DRIVER"?

Thanks,
Stefano

