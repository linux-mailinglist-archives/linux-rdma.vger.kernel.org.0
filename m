Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE222C88FC
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 17:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgK3QJJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 11:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgK3QJJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Nov 2020 11:09:09 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957F8C0613CF
        for <linux-rdma@vger.kernel.org>; Mon, 30 Nov 2020 08:08:23 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id t5so8514779qtp.2
        for <linux-rdma@vger.kernel.org>; Mon, 30 Nov 2020 08:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LnvYCaUrTiypHZ/aT7vJGFEAxYKcosThUHM5obbTnQc=;
        b=OgTOfaY0SCCNec/T6B86kXclX8n4mexFUUhbri8EsGfzATLk8V+xx4xiiajAWefYoD
         Bk5kSC2iWCH2m48oPU1yWJ1vK32rtv1CfChI2u8jUO90Z9TFqF3Kkh2hs2DaE3TIa01K
         Rwl56hPFWkZTY4JKUTiiAelg7sgXoffuM3JaOnPv4c0sUjg7DZPVcrTyFulnLTM7oeG6
         WX9MngUBVjirIS2ts+EB0ZX28eT38bYSYgZj3Box+gEQJ2frWXLOvpsgcaHAN2WRX015
         zYzungsCNl2HDTm4Ow4Opbu9cUiceaNVFrsGYXFdWbjsYfFwl7Zfb3eVmn9WkXMz2W/p
         3ABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LnvYCaUrTiypHZ/aT7vJGFEAxYKcosThUHM5obbTnQc=;
        b=kjhHYr+dYWBie6+I7xltlIFs0q3fhDKN3ddO10iljJujEyRzw/wc0t3oug7t5W01p5
         flTIVWri5Umyek0B7cWSIAHB1LEx2SQNbSvztz9IKwTBj/XAW2xKts+m2R7YL50ZzRSa
         Lfn7qrhg2/oHu2l7MhMbFIaF3Pfz2eljgEK5oBNjecHmOAsJDB+sb8dPnT3TS2CAXUw9
         3gPa7KxWlia2xnb+t5rUq4ywf+VW8hMEE1T4WOFMEeUd/i8WG+J2IcDVjsdKNMcsZJPt
         lnbijzerJdRfQejy738K6kX0MbxS2G5RFscctGiM6kaJ/wHoAtcZCzlL3b6S9n4SbB24
         yzQQ==
X-Gm-Message-State: AOAM530nIcgTQRM4h0lzdvmmnPxvY3udLUCb5S6omEZFzIyJ5lWRc55F
        Ml/Lr2zobdFdsm197ISVN83Klw==
X-Google-Smtp-Source: ABdhPJzaC9nNQuKVHSa4dQb6+9eRJzS8/L1kl6NOzzKawO6uSmTDYgY/Yun1/Kkk0XX4EZ3jxftvJw==
X-Received: by 2002:aed:2b03:: with SMTP id p3mr22921117qtd.167.1606752502767;
        Mon, 30 Nov 2020 08:08:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id c27sm16061169qkk.57.2020.11.30.08.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:08:21 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kjliv-0045Oj-20; Mon, 30 Nov 2020 12:08:21 -0400
Date:   Mon, 30 Nov 2020 12:08:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH rdma-core v3 4/6] pyverbs: Add dma-buf based MR support
Message-ID: <20201130160821.GB5487@ziepe.ca>
References: <1606510543-45567-1-git-send-email-jianxin.xiong@intel.com>
 <1606510543-45567-5-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606510543-45567-5-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 27, 2020 at 12:55:41PM -0800, Jianxin Xiong wrote:
>  
> +function(rdma_multifile_module PY_MODULE MODULE_NAME LINKER_FLAGS)

I think just replace rdma_cython_module with this? No good reason I
can see to have two APIs?

> +  set(ALL_CFILES "")
> +  foreach(SRC_FILE ${ARGN})
> +    get_filename_component(FILENAME ${SRC_FILE} NAME_WE)
> +    get_filename_component(DIR ${SRC_FILE} DIRECTORY)
> +    get_filename_component(EXT ${SRC_FILE} EXT)
> +    if (DIR)
> +      set(SRC_PATH "${CMAKE_CURRENT_SOURCE_DIR}/${DIR}")
> +    else()
> +      set(SRC_PATH "${CMAKE_CURRENT_SOURCE_DIR}")
> +    endif()
> +    if (${EXT} STREQUAL ".pyx")
> +      set(PYX "${SRC_PATH}/${FILENAME}.pyx")
> +      set(CFILE "${CMAKE_CURRENT_BINARY_DIR}/${FILENAME}.c")
> +      include_directories(${PYTHON_INCLUDE_DIRS})
> +      add_custom_command(
> +        OUTPUT "${CFILE}"
> +        MAIN_DEPENDENCY "${PYX}"
> +        COMMAND ${CYTHON_EXECUTABLE} "${PYX}" -o "${CFILE}"
> +        "-I${PYTHON_INCLUDE_DIRS}"
> +        COMMENT "Cythonizing ${PYX}"
> +      )
> +      set(ALL_CFILES "${ALL_CFILES};${CFILE}")
> +    elseif(${EXT} STREQUAL ".c")
> +      set(CFILE_ORIG "${SRC_PATH}/${FILENAME}.c")
> +      set(CFILE "${CMAKE_CURRENT_BINARY_DIR}/${FILENAME}.c")
> +      if (NOT ${CFILE_ORIG} STREQUAL ${CFILE})
> +        rdma_create_symlink("${CFILE_ORIG}" "${CFILE}")
> +      endif()

Why does this need the create_symlink? The compiler should work OK
from the source file?

> +      set(ALL_CFILES "${ALL_CFILES};${CFILE}")
> +    elseif(${EXT} STREQUAL ".h")
> +      set(HFILE_ORIG "${SRC_PATH}/${FILENAME}.h")
> +      set(HFILE "${CMAKE_CURRENT_BINARY_DIR}/${FILENAME}.h")
> +      if (NOT ${HFILE_ORIG} STREQUAL ${HFILE})
> +        rdma_create_symlink("${HFILE_ORIG}" "${HFILE}")

Here too? You probably don't need to specify h files at all, at worst
they should only be used with publish_internal_headers

> +      endif()
> +    else()
> +      continue()
> +    endif()
> +  endforeach()
> +  string(REGEX REPLACE "\\.so$" "" SONAME "${MODULE_NAME}${CMAKE_PYTHON_SO_SUFFIX}")
> +  add_library(${SONAME} SHARED ${ALL_CFILES})
> +  set_target_properties(${SONAME} PROPERTIES
> +    COMPILE_FLAGS "${CMAKE_C_FLAGS} -fPIC -fno-strict-aliasing -Wno-unused-function -Wno-redundant-decls -Wno-shadow -Wno-cast-function-type -Wno-implicit-fallthrough -Wno-unknown-warning -Wno-unknown-warning-option -Wno-deprecated-declarations ${NO_VAR_TRACKING_FLAGS}"

Ugh, you copy and pasted this, but it shouldn't have existed in the
first place. Compiler arguments like this should not be specified
manually. I should fix it..

Also you should cc edward on all this pyverbs stuff, he knows it all
very well

It all looks reasonable to me

Jason

