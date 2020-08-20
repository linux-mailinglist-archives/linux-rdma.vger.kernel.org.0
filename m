Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF6A24AF3F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 08:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgHTGc5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 02:32:57 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:35217 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgHTGc4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 02:32:56 -0400
Received: by mail-ej1-f65.google.com with SMTP id a26so1244225ejc.2
        for <linux-rdma@vger.kernel.org>; Wed, 19 Aug 2020 23:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SgEFdKBZY//GtW7WsFuomYHty6ucGmzytYgl2NILbLg=;
        b=VyosDkLgBNCmPlir8CnR3OiaHZcPxipF6SPwXj3CGcJutT1MD41E+ky1vAxGNEmWAZ
         f8nk6JLyyy1ZxLFAs7GsDiAHTBq/DCkDte924dqc/cjlrHPalLv0OFd4tHZla3iB1/U+
         cVHoEafV1ylRno01XG60Rf59rP2bd/dY/xeTBLtw8kMoN1xgdO8B5huH+CtTnpwdc/ui
         JZgVwDC+o5PiOIYa65FQDLV+j1t3aMUawe7yxZ6kfprvbeg/mMckOk3FxbwXnYdRYuR+
         uUOXCqVitvrx3RSX8hKzb0tTCCpTAwo5JKEhkvtgv+ISIZ61jvgPtiRrd2w3z0ZQ4jIl
         PIDA==
X-Gm-Message-State: AOAM5320FlzYdwWPS5EmxVTrSsmCLr7rHUDwskG7EBLPZRnEsyi2LJkJ
        PdChaqEvW50NFXYL7lDESwJX6dsF6DY=
X-Google-Smtp-Source: ABdhPJyHawhDiHi/8EM4M6MQhQhAbU8noSyyH9M22iSRBN8m/XtenQpygiq47OuBbRtJNtz77xVc2A==
X-Received: by 2002:a17:906:ca5a:: with SMTP id jx26mr1780134ejb.62.1597905174107;
        Wed, 19 Aug 2020 23:32:54 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id y9sm707523edt.34.2020.08.19.23.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 23:32:53 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/virtio: Remove open-coded commit-tail function
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <20200709123339.547390-2-daniel.vetter@ffwll.ch>
 <5cb80369-75a5-fc83-4683-3a6fc2814104@kernel.org>
 <20200819132408.jnqjhdgd4jbnarhh@sirius.home.kraxel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <8a80b434-c8ed-daa3-753b-dd2ec89b9067@kernel.org>
Date:   Thu, 20 Aug 2020 08:32:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819132408.jnqjhdgd4jbnarhh@sirius.home.kraxel.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 19. 08. 20, 15:24, Gerd Hoffmann wrote:
> On Wed, Aug 19, 2020 at 02:43:28PM +0200, Jiri Slaby wrote:
>> On 09. 07. 20, 14:33, Daniel Vetter wrote:
>>> Exactly matches the one in the helpers.
>>
>> It's not that exact. The order of modeset_enables and planes is
>> different. And this causes a regression -- no fb in qemu.
> 
> Does https://patchwork.freedesktop.org/patch/385980/ help?

Yes, it does.

thanks,
-- 
js
suse labs
